import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PlateMask {
  static TextInputFormatter dynamic() {
    return MaskTextInputFormatter(
      mask: 'AAA-#A##',
      filter: {
        'A': RegExp(r'[A-Z]'),
        '#': RegExp(r'[0-9]'),
      },
    );
  }
}

