import 'dart:io';

import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/ui/extensions/build_context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AppAlert {
  AppAlert._();

  static Future<void> error(
    BuildContext context, {
    required AppError? error,
  }) async {
    if (error == null) return;

    return dialog(
      context,
      title: error.title ?? context.l10n.error_title,
      message: error.message,
    );
  }

  static Future<void> dialog(
    BuildContext context, {
    required String title,
    required String? message,
    bool barrierDismissible = true,
    bool dismissOnAction = true,
    VoidCallback? onAction,
  }) {
    HapticFeedback.mediumImpact();
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        void onPressed() {
          if (dismissOnAction) {
            dialogContext.pop();
          }
          onAction?.call();
        }

        final confirm = context.l10n.common_ok;

        return AlertDialog.adaptive(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: [
            Platform.isIOS
                ? CupertinoDialogAction(
                    onPressed: onPressed,
                    child: Text(confirm),
                  )
                : TextButton(onPressed: onPressed, child: Text(confirm)),
          ],
        );
      },
    );
  }

  static Future<void> confirmation(
    BuildContext context, {
    required String title,
    required String? message,
    bool barrierDismissible = true,
    bool isDestructive = false,
    String? confirmText,
    required VoidCallback onConfirm,
  }) {
    HapticFeedback.mediumImpact();
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        void cancelAction() {
          dialogContext.pop();
        }

        void confirmAction() {
          dialogContext.pop();
          onConfirm.call();
        }

        final confirm = confirmText ?? context.l10n.common_ok;
        final cancel = context.l10n.common_cancel;

        return AlertDialog.adaptive(
          title: Text(title),
          content: message != null ? Text(message) : null,
          actions: Platform.isIOS
              ? [
                  CupertinoDialogAction(
                    onPressed: cancelAction,
                    child: Text(cancel),
                  ),
                  CupertinoDialogAction(
                    onPressed: confirmAction,
                    isDefaultAction: true,
                    isDestructiveAction: isDestructive,
                    child: Text(confirm),
                  ),
                ]
              : [
                  TextButton(onPressed: cancelAction, child: Text(cancel)),
                  FilledButton(
                    onPressed: confirmAction,
                    style: FilledButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: isDestructive
                          ? Theme.of(context).colorScheme.errorContainer
                          : null,
                    ),
                    child: Text(confirm),
                  ),
                ],
        );
      },
    );
  }
}
