import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/icon_constants.dart';
import 'package:sadamov/view/components/icon/svg_icon.dart';
import 'package:sadamov/view/components/button/custom_button.dart';

/// Tela de sucesso após registro da ocorrência
/// Exibe informações da ocorrência registrada
class SuccessPage extends StatelessWidget {
  final Map<String, dynamic>? occurrence;

  const SuccessPage({
    super.key,
    this.occurrence,
  });

  @override
  Widget build(BuildContext context) {
    final plate = occurrence?['plate'] ?? '';
    final responsible = occurrence?['responsible'] ?? '';
    final createdAt = occurrence?['createdAt'] as DateTime? ?? DateTime.now();
    final formattedDate =
        DateFormat('dd/MM/yyyy \'às\' HH:mm').format(createdAt);

    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Concluído',
          style: AppTextStyles.titleLarge(context: context)
              .textStyle(context)
              .copyWith(color: Colors.white),
        ),
        backgroundColor: ThemeColor.actionPrimaryColor.color(context),
        elevation: AppElevation.none,
        centerTitle: true,
        leading: IconButton(
          icon: SvgIcon(
            assetPath: AppIcons.arrowLeftSvg,
            width: AppIconSizes.medium,
            height: AppIconSizes.medium,
            color: Colors.white,
          ),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.large,
                    vertical: AppPadding.extraLarge * 1.5,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppPadding.large),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.small),
                        ),
                        child: Column(
                          children: [
                            SvgIcon(
                              assetPath: AppIcons.box,
                              width: AppIconSizes.extraHuge,
                              height: AppIconSizes.extraHuge,
                              color:
                                  ThemeColor.actionPrimaryColor.color(context),
                            ),
                            const SizedBox(height: AppPadding.large),
                            Text(
                              'Registrado',
                              style: AppTextStyles.headlineLarge(
                                context: context,
                                bold: true,
                              ).textStyle(context),
                            ),
                            const SizedBox(height: AppPadding.small),
                            Text(
                              'Ocorrência registrada com sucesso.\nOs seguintes dados foram gravados:',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium(context: context)
                                  .textStyle(context),
                            ),
                            const SizedBox(height: AppPadding.large),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.extraLarge,
                                vertical: AppPadding.large,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeColor.surfacesFields.color(context),
                                borderRadius: BorderRadius.circular(
                                    AppBorderRadius.regSmall),
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                      context, 'Serviços:', 'Ocorrência'),
                                  const SizedBox(height: AppPadding.smallest),
                                  _buildInfoRow(
                                      context, 'Responsável:', responsible),
                                  const SizedBox(height: AppPadding.smallest),
                                  _buildInfoRow(
                                      context, 'Data e hora:', formattedDate),
                                  const SizedBox(height: AppPadding.smallest),
                                  _buildInfoRow(context, 'Veículo:', plate),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.large),
              child: CustomButton(
                text: 'OK',
                onPressed: () {
                  Modular.to.pushNamedAndRemoveUntil(
                    '/',
                    (_) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói uma linha de informação (label: valor)
  /// Usado para exibir dados da ocorrência registrada
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppLabelSizes.infoRow,
          child: Text(
            label,
            style:
                AppTextStyles.bodyMedium(context: context).textStyle(context),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyMedium(
              context: context,
              bold: true,
            ).textStyle(context),
          ),
        ),
      ],
    );
  }
}
