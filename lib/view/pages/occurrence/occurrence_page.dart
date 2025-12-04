import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/store/occurrence/occurrence_store.dart';
import 'package:sadamov/view/components/form/custom_text_form_field.dart';
import 'package:sadamov/view/components/form/mask/plate_mask.dart';
import 'package:sadamov/view/components/form/validation/plate_validator.dart';
import 'package:sadamov/view/components/photo/photo_capture_widget.dart';
import 'package:sadamov/view/components/button/custom_button.dart';
import 'package:sadamov/utils/services/camera_service.dart';

class OccurrencePage extends StatefulWidget {
  const OccurrencePage({super.key});

  @override
  State<OccurrencePage> createState() => _OccurrencePageState();
}

class _OccurrencePageState extends State<OccurrencePage> {
  final _plateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final OccurrenceStore _store;
  late final CameraService _cameraService;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<OccurrenceStore>();
    _cameraService = Modular.get<CameraService>();
  }

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    try {
      final photo = await _cameraService.capturePhoto();
      if (photo != null) {
        _store.addPhoto(photo);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Ocorrência',
          style: AppTextStyles.titleLarge(context: context).textStyle(context),
        ),
        backgroundColor: ThemeColor.transparent.color(context),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: Observer(
        builder: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.regular),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: _plateController,
                  labelText: 'Placa Veículo',
                  hintText: 'Placa',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    PlateMask.dynamic(),
                    LengthLimitingTextInputFormatter(8),
                  ],
                  validator: plateFieldValidator,
                  onChanged: (value) {
                    _store.setPlateNumber(value);
                  },
                ),
                const SizedBox(height: AppPadding.large),
                Text(
                  'Fotos (mínimo 1)',
                  style: AppTextStyles.titleMedium(context: context)
                      .textStyle(context),
                ),
                const SizedBox(height: AppPadding.regular),
                Wrap(
                  spacing: AppPadding.regular,
                  runSpacing: AppPadding.regular,
                  children: [
                    ..._store.photos.asMap().entries.map(
                      (entry) {
                        final index = entry.key;
                        final photo = entry.value;
                        return PhotoCaptureWidget(
                          photoBytes: photo,
                          onCapture: _capturePhoto,
                          onRemove: () => _store.removePhoto(index),
                        );
                      },
                    ),
                    PhotoCaptureWidget(
                      onCapture: _capturePhoto,
                    ),
                  ],
                ),
                const SizedBox(height: AppPadding.extraLarge),
                CustomButton(
                  text: 'Avançar',
                  onPressed: _store.canProceedToNextStep
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            Modular.to.pushNamed('/review');
                          }
                        }
                      : null,
                  isEnabled: _store.canProceedToNextStep,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

