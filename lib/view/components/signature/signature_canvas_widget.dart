import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/constants.dart';

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
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColor.actionPrimaryColor.color(context),
            ),
            borderRadius: BorderRadius.circular(AppBorderRadius.small),
          ),
          child: Stack(
            children: [
              Image.memory(signatureBytes!),
              Positioned(
                bottom: 8,
                right: 8,
                child: TextButton(
                  onPressed: onEdit,
                  child: const Text('Editar assinatura'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onEdit,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: ThemeColor.actionPrimaryColor.color(context),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppBorderRadius.small),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 48,
              color: ThemeColor.actionPrimaryColor.color(context),
            ),
            const SizedBox(height: AppPadding.small),
            Text(
              'Adicionar assinatura',
              style: TextStyle(
                color: ThemeColor.actionPrimaryColor.color(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

