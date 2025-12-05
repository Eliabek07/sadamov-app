import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/icon_constants.dart';
import 'package:sadamov/view/components/icon/svg_icon.dart';

/// Widget para captura e exibição de fotos
/// Exibe foto capturada ou botão para capturar nova foto
class PhotoCaptureWidget extends StatelessWidget {
  final Uint8List? photoBytes;
  final VoidCallback onCapture;
  final VoidCallback? onRemove;

  const PhotoCaptureWidget({
    super.key,
    this.photoBytes,
    required this.onCapture,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (photoBytes != null) {
      return Stack(
        children: [
          Container(
            width: AppPhotoSizes.regular,
            height: AppPhotoSizes.regular,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.small),
              color: ThemeColor.surfacesFields.color(context),
              image: DecorationImage(
                image: MemoryImage(photoBytes!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: AppPadding.small,
              right: AppPadding.small,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.smallest),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    AppIcons.close,
                    color: Colors.white,
                    size: AppIconSizes.regular,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return GestureDetector(
      onTap: onCapture,
      child: Container(
        width: AppPhotoSizes.regular,
        height: AppPhotoSizes.regular,
        decoration: BoxDecoration(
          color: ThemeColor.surfacesFields.color(context),
          borderRadius: BorderRadius.circular(AppBorderRadius.small),
        ),
        child: Stack(
          children: [
            Center(
              child: SvgIcon(
                assetPath: AppIcons.cameraAddSvg,
                width: AppIconSizes.huge,
                height: AppIconSizes.huge,
                color: ThemeColor.textSecondaryColor.color(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
