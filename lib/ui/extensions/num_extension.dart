import 'package:intl/intl.dart';

extension NumFormatting on num {
  String get thousandSeparated {
    final formatter = NumberFormat('#,###.##');
    return formatter.format(this);
  }
}
