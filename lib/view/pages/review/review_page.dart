import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/store/occurrence/occurrence_store.dart';
import 'package:sadamov/view/components/form/custom_text_form_field.dart';
import 'package:sadamov/view/components/form/validation/validation.dart';
import 'package:sadamov/view/components/signature/signature_canvas_widget.dart';
import 'package:sadamov/view/components/button/custom_button.dart';
import 'package:sadamov/view/pages/signature/signature_draw_page.dart';
import 'dart:typed_data';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _responsibleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final OccurrenceStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<OccurrenceStore>();
  }

  @override
  void dispose() {
    _responsibleController.dispose();
    super.dispose();
  }

  Future<void> _openSignatureDrawer() async {
    final signature = await Modular.to.push<Uint8List>(
      MaterialPageRoute(
        builder: (_) => const SignatureDrawPage(),
      ),
    );

    if (signature != null) {
      _store.setSignature(signature);
    }
  }

  Future<void> _finalize() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await _store.saveOccurrence();
      if (mounted) {
        Modular.to.pushReplacementNamed(
          '/success',
          arguments: {
            'plate': _store.plateNumber,
            'responsible': _store.responsibleName,
            'createdAt': DateTime.now(),
          },
        );
        _store.reset();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
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
          'Revisão',
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
                  controller: _responsibleController,
                  labelText: 'Responsável',
                  hintText: 'Responsável',
                  validator: validate([
                    notEmpty(),
                    length(min: 3, max: 100),
                  ]),
                  onChanged: (value) {
                    _store.setResponsibleName(value);
                  },
                ),
                const SizedBox(height: AppPadding.large),
                Text(
                  'Assinatura',
                  style: AppTextStyles.titleMedium(context: context)
                      .textStyle(context),
                ),
                const SizedBox(height: AppPadding.regular),
                SignatureCanvasWidget(
                  signatureBytes: _store.signature,
                  onEdit: _openSignatureDrawer,
                ),
                const SizedBox(height: AppPadding.extraLarge),
                CustomButton(
                  text: 'Finalizar',
                  onPressed: _store.canFinalize ? _finalize : null,
                  isEnabled: _store.canFinalize,
                  isLoading: _store.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

