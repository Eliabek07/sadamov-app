import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sadamov/constants/colors_constants.dart';
import 'package:sadamov/constants/text_style_constants.dart';
import 'package:sadamov/constants/constants.dart';
import 'package:sadamov/constants/icon_constants.dart';
import 'package:sadamov/view/components/icon/svg_icon.dart';
import 'package:sadamov/view/components/button/custom_button.dart';

/// Tela para desenhar assinatura digital
/// Permite desenhar, limpar e confirmar a assinatura
class SignatureDrawPage extends StatefulWidget {
  const SignatureDrawPage({super.key});

  @override
  State<SignatureDrawPage> createState() => _SignatureDrawPageState();
}

class _SignatureDrawPageState extends State<SignatureDrawPage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: AppStrokeWidth.small,
    penColor: Colors.black,
  );
  final ValueNotifier<bool> _isEmptyNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _isEmptyNotifier.value = _controller.isEmpty;
  }

  @override
  void dispose() {
    _controller.dispose();
    _isEmptyNotifier.dispose();
    super.dispose();
  }

  /// Atualiza o estado de vazio da assinatura
  /// Usado para habilitar/desabilitar botão de confirmar
  void _updateIsEmpty() {
    _isEmptyNotifier.value = _controller.isEmpty;
  }

  /// Confirma a assinatura desenhada
  /// Converte para PNG e retorna os bytes para a tela anterior
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.small),
            child: TextButton.icon(
              onPressed: () {
                _controller.clear();
                _updateIsEmpty();
              },
              icon: SvgIcon(
                assetPath: AppIcons.eraserSvg,
                width: AppIconSizes.medium,
                height: AppIconSizes.medium,
                color: Colors.white,
              ),
              label: Text(
                'Limpar',
                style: AppTextStyles.bodyMedium(context: context)
                    .textStyle(context)
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerDown: (_) {
                Future.microtask(() => _updateIsEmpty());
              },
              onPointerMove: (_) {
                Future.microtask(() => _updateIsEmpty());
              },
              onPointerUp: (_) {
                Future.microtask(() => _updateIsEmpty());
              },
              child: Signature(
                controller: _controller,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppPadding.large),
            color: Colors.white,
            child: ValueListenableBuilder<bool>(
              valueListenable: _isEmptyNotifier,
              builder: (context, isEmpty, child) {
                return CustomButton(
                  text: 'Confirmar',
                  onPressed: _confirmSignature,
                  isEnabled: !isEmpty,
                  leftIconSvg: AppIcons.penSvg,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
