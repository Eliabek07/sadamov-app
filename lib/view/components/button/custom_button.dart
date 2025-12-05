import 'package:flutter/material.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/icon_constants.dart';
import 'package:sadamov/view/components/icon/svg_icon.dart';

/// Botão customizado reutilizável
/// Suporta estados habilitado/desabilitado, loading e ícones opcionais
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? leftIconSvg;
  final String? rightIconSvg;
  final bool showRightIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.leftIcon,
    this.rightIcon,
    this.leftIconSvg,
    this.rightIconSvg,
    this.showRightIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = isEnabled && !isLoading;
    final textColor = isButtonEnabled ? Colors.white : const Color(0xFF9CA3AF);
    final iconColor = isButtonEnabled ? Colors.white : const Color(0xFF9CA3AF);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isButtonEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColor.actionPrimaryColor.color(context),
          disabledBackgroundColor: ThemeColor.actionDisabled.color(context),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.large,
            vertical: AppPadding.regular,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.small),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: AppIconSizes.regular,
                width: AppIconSizes.regular,
                child: CircularProgressIndicator(
                  strokeWidth: AppStrokeWidth.small,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leftIconSvg != null) ...[
                    SvgIcon(
                      assetPath: leftIconSvg!,
                      width: AppIconSizes.regular,
                      height: AppIconSizes.regular,
                      color: iconColor,
                    ),
                    const SizedBox(width: AppPadding.small),
                  ] else if (leftIcon != null) ...[
                    Icon(leftIcon,
                        color: iconColor, size: AppIconSizes.regular),
                    const SizedBox(width: AppPadding.small),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.bodyLarge(
                      context: context,
                      bold: true,
                    ).textStyle(context).copyWith(color: textColor),
                  ),
                  if (showRightIcon && rightIconSvg != null) ...[
                    const SizedBox(width: AppPadding.small),
                    SvgIcon(
                      assetPath: isButtonEnabled 
                          ? rightIconSvg! 
                          : (rightIconSvg == AppIcons.arrowRightSvg 
                              ? AppIcons.arrowRightSvgDisabled 
                              : rightIconSvg!),
                      width: AppIconSizes.regular,
                      height: AppIconSizes.regular,
                      preserveOriginalColors: true,
                    ),
                  ] else if (showRightIcon && rightIcon != null) ...[
                    const SizedBox(width: AppPadding.small),
                    Icon(rightIcon,
                        color: iconColor, size: AppIconSizes.regular),
                  ],
                ],
              ),
      ),
    );
  }
}
