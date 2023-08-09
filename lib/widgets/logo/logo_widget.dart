import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Widget du logo
/// Affiche le logo en fonction du thème
class Logo extends StatelessWidget {
  /// Chemins des logos en fonction du thème
  final Map<Brightness, String> logoPaths = const {
    Brightness.light: 'assets/logo/logo-animation-light.svg',
    Brightness.dark: 'assets/logo/logo-animation-dark.svg',
  };

  /// Largeur du logo
  final double? width;

  /// Hauteur du logo
  final double? height;

  /// Constructeur
  const Logo({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Affiche le logo
    return SvgPicture.asset(
      logoPaths[Theme.of(context).brightness]!,
      width: width,
      height: height,
    );
  }
}
