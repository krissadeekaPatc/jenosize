class Decoder {
  Decoder._();

  static num? toNum(dynamic input) {
    if (input is num) {
      return input;
    } else if (input is String) {
      return num.tryParse(input);
    } else {
      return null;
    }
  }

  static int? toInt(dynamic input) {
    return toNum(input)?.toInt();
  }

  static double? toDouble(dynamic input) {
    return toNum(input)?.toDouble();
  }

  static Uri? toUri(dynamic input) {
    if (input is String) {
      return Uri.tryParse(input);
    } else {
      return null;
    }
  }
}
