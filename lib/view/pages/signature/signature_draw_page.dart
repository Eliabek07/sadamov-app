import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';

class SignatureDrawPage extends StatefulWidget {
  const SignatureDrawPage({super.key});

  @override
  State<SignatureDrawPage> createState() => _SignatureDrawPageState();
}

class _SignatureDrawPageState extends State<SignatureDrawPage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _confirmSignature() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, desenhe sua assinatura')),
      );
      return;
    }

    final signatureBytes = await _controller.toPngBytes();
    if (signatureBytes != null) {
      Modular.to.pop(signatureBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.surfacesBackground.color(context),
      appBar: AppBar(
        title: Text(
          'Assinatura',
          style: AppTextStyles.titleLarge(context: context).textStyle(context),
        ),
        backgroundColor: ThemeColor.transparent.color(context),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _controller.clear,
            child: Text(
              'Limpar',
              style: AppTextStyles.bodyLarge(context: context)
                  .textStyle(context),
            ),
          ),
          TextButton(
            onPressed: _confirmSignature,
            child: Text(
              'Confirmar',
              style: AppTextStyles.bodyLarge(
                context: context,
                bold: true,
              ).textStyle(context),
            ),
          ),
        ],
      ),
      body: Signature(
        controller: _controller,
        backgroundColor: Colors.white,
      ),
    );
  }
}

