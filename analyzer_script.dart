// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:collection/collection.dart';

class EquatableVisitor extends RecursiveAstVisitor<void> {
  final List<String> classesWithMissingProps = [];

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.extendsClause?.superclass.toSource() == 'Equatable') {
      final propsField = node.members
          .whereType<MethodDeclaration>()
          .firstWhereOrNull(
            (method) => method.name.lexeme == 'props',
          );

      final declaredFields = node.members
          .whereType<FieldDeclaration>()
          .where((e) => !e.isStatic)
          .expand((fieldDecl) => fieldDecl.fields.variables)
          .map((variable) => variable.name.lexeme)
          .toList();

      if (propsField == null ||
          !declaredFields.every(
            (field) => propsField.body.toSource().contains(field),
          )) {
        classesWithMissingProps.add(node.name.lexeme);
      }
    }
    super.visitClassDeclaration(node);
  }
}

void main() {
  const path = 'lib/';
  final visitor = EquatableVisitor();

  Directory(path)
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .forEach((file) {
        final result = parseFile(
          path: file.path,
          featureSet: FeatureSet.latestLanguageVersion(),
        );
        result.unit.visitChildren(visitor);
      });

  final classesWithMissingProps = visitor.classesWithMissingProps;
  if (classesWithMissingProps.isNotEmpty) {
    List<String> messages = ['::warning::'];

    final count = classesWithMissingProps.length;
    messages.add(
      [
        'There are',
        count,
        count == 1 ? 'class' : 'classes',
        'extending Equatable but missing some props:',
      ].join(' '),
    );
    messages.addAll(
      classesWithMissingProps.asMap().entries.map(
        (e) => '${e.key + 1}. ${e.value}',
      ),
    );
    _printYellow('${messages.join('\n')}\n');
  } else {
    _printGreen(
      'All Equatable classes have all their variables included in props.\n',
    );
  }
}

void _printGreen(String text) {
  print('\x1B[32m$text\x1B[0m');
}

void _printYellow(String text) {
  print('\x1B[33m$text\x1B[0m');
}
