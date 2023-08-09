import 'package:flutter/material.dart';

/// Bouton en couleur primaire
class PrimaryButton extends StatelessWidget {
  /// Texte du bouton
  final String text;

  /// Action du bouton
  final void Function() onPressed;

  /// Constructeur
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
