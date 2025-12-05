import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/icon_constants.dart';
import 'package:sadamov/view/components/icon/svg_icon.dart';

/// Tela inicial do aplicativo
/// Exibe card "Ocorrência" que navega para o fluxo de registro
class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Checklist',
          style: AppTextStyles.titleLarge(context: context)
              .textStyle(context)
              .copyWith(color: Colors.white),
        ),
        backgroundColor: ThemeColor.actionPrimaryColor.color(context),
        elevation: AppElevation.none,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.large),
        child: Card(
          elevation: AppElevation.small,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.small),
          ),
          child: InkWell(
            onTap: () {
              Modular.to.pushNamed('/occurrence');
            },
            borderRadius: BorderRadius.circular(AppBorderRadius.small),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.large,
                vertical: AppPadding.regular,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppPadding.small),
                    decoration: BoxDecoration(
                      color: ThemeColor.surfacesFields.color(context),
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.regSmall),
                    ),
                    child: SvgIcon(
                      assetPath: AppIcons.boxSvg,
                      width: AppIconSizes.huge,
                      height: AppIconSizes.huge,
                      color: ThemeColor.actionPrimaryColor.color(context),
                    ),
                  ),
                  const SizedBox(width: AppPadding.regular),
                  Expanded(
                    child: Text(
                      'Ocorrência',
                      style: AppTextStyles.bodyLarge(context: context)
                          .textStyle(context),
                    ),
                  ),
                  SvgIcon(
                    assetPath: AppIcons.arrowRightAltSvg,
                    width: AppIconSizes.medium,
                    height: AppIconSizes.medium,
                    color: ThemeColor.textSecondaryColor.color(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
