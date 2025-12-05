import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/colors_constants.dart';

/// Widget para exibir assinatura digital
/// Mostra assinatura capturada ou placeholder para edição
class SignatureCanvasWidget extends StatelessWidget {
  final Uint8List? signatureBytes;
  final VoidCallback onEdit;

  const SignatureCanvasWidget({
    super.key,
    this.signatureBytes,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (signatureBytes != null) {
      return GestureDetector(
        onTap: onEdit,
        child: Container(
          height: AppSignatureSizes.height,
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColor.borderDefault.color(context),
            ),
            borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
            child: Image.memory(
              signatureBytes!,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onEdit,
      child: Container(
        height: AppSignatureSizes.height,
        decoration: BoxDecoration(
          color: ThemeColor.surfacesFields.color(context),
          border: Border.all(
            color: ThemeColor.borderDefault.color(context),
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
        ),
        child: Center(
          child: Text(
            'Assinatura',
            style: AppTextStyles.bodyMedium(context: context)
                .textStyle(context)
                .copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
          ),
        ),
      ),
    );
  }
}

