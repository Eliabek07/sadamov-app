import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Checklist',
          style: AppTextStyles.titleLarge(context: context).textStyle(context),
        ),
        backgroundColor: ThemeColor.transparent.color(context),
        elevation: 0,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(AppPadding.regular),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.small),
          ),
          child: ListTile(
            title: Text(
              'Ocorrência',
              style: AppTextStyles.titleMedium(context: context)
                  .textStyle(context),
            ),
            subtitle: Text(
              'Registrar nova ocorrência',
              style: AppTextStyles.bodyMedium(context: context)
                  .textStyle(context),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Modular.to.pushNamed('/occurrence');
            },
          ),
        ),
      ),
    );
  }
}

