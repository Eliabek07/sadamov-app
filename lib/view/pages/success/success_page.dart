import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/view/components/button/custom_button.dart';

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
    final formattedDate = DateFormat('dd/MM/yyyy \'às\' HH:mm').format(createdAt);

    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Concluído',
          style: AppTextStyles.titleLarge(context: context).textStyle(context),
        ),
        backgroundColor: ThemeColor.transparent.color(context),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.regular),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.small),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.large),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
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
                    padding: const EdgeInsets.all(AppPadding.large),
                    decoration: BoxDecoration(
                      color: ThemeColor.surfacesFields.color(context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(context, 'Serviços:', 'Ocorrência'),
                        const SizedBox(height: 2),
                        _buildInfoRow(context, 'Responsável:', responsible),
                        const SizedBox(height: 2),
                        _buildInfoRow(context, 'Data e hora:', formattedDate),
                        const SizedBox(height: 2),
                        _buildInfoRow(context, 'Veículo:', plate),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppPadding.extraLarge),
                  CustomButton(
                    text: 'OK',
                    onPressed: () {
                      Modular.to.pushReplacementNamed('/');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 91,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium(context: context).textStyle(context),
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

