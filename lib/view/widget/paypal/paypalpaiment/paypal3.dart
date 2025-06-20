import 'package:flutter/services.dart';

class GenericInputFormatter extends TextInputFormatter {
  final String separator;
  final int maxLength;
  final List<int> separatorPositions;

  GenericInputFormatter({
    required this.separator,
    required this.maxLength,
    required this.separatorPositions,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(separator, '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length && i < maxLength; i++) {
      if (separatorPositions.contains(i)) buffer.write(separator);
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CardNumberInputFormatter extends GenericInputFormatter {
  CardNumberInputFormatter()
      : super(
    separator: ' ',
    maxLength: 16,
    separatorPositions: [4, 8, 12],
  );
}

class ExpiryDateInputFormatter extends GenericInputFormatter {
  ExpiryDateInputFormatter()
      : super(
    separator: '/',
    maxLength: 4,
    separatorPositions: [2],
  );
}