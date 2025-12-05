import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';

/// Campo de texto customizado reutilizável
/// Suporta label, hint, validação, máscaras e estado readonly
class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textCapitalization,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.bodyMedium(
              context: context,
            ).textStyle(context),
          ),
          const SizedBox(height: AppPadding.smallest),
        ],
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: ThemeColor.surfacesFields.color(context),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
              borderSide: BorderSide(
                color: ThemeColor.borderDefault.color(context),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
              borderSide: BorderSide(
                color: ThemeColor.borderDefault.color(context),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
              borderSide: BorderSide(
                color: ThemeColor.borderDefault.color(context),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
              borderSide: BorderSide(
                color: ThemeColor.textTextErrors.color(context),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.regSmall),
              borderSide: BorderSide(
                color: ThemeColor.textTextErrors.color(context),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.regular + AppPadding.smallest,
              vertical: readOnly 
                  ? AppPadding.regular + AppPadding.smallest 
                  : AppPadding.small + AppPadding.smallest,
            ),
          ),
          style: AppTextStyles.bodyLarge(context: context).textStyle(context),
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
        ),
      ],
    );
  }
}

