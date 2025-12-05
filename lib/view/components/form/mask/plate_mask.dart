import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Classe para máscaras de entrada de placa de veículo
/// Fornece formatter dinâmico que aceita formatos antigo e novo
class PlateMask {
  /// Retorna formatter dinâmico para placa
  /// Máscara: AAA-#A## (aceita letras e números conforme padrão)
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

