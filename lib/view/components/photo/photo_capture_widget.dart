import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/constants.dart';

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
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppBorderRadius.small),
              image: DecorationImage(
                image: MemoryImage(photoBytes!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
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
        width: 150,
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
              Icons.camera_alt,
              size: 48,
              color: ThemeColor.actionPrimaryColor.color(context),
            ),
            const SizedBox(height: AppPadding.small),
            Text(
              'Tirar foto',
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

