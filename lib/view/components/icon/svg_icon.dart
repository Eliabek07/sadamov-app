import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget para exibir ícones SVG
/// Suporta colorização e preservação de cores originais
class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final bool preserveOriginalColors;

  const SvgIcon({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.preserveOriginalColors = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: preserveOriginalColors || color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
