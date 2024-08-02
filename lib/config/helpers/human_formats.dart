import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadableNumber(double number) {
    final fortmatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);

    return fortmatterNumber;
  }
}
