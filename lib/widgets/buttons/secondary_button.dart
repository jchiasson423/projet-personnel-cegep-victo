import 'package:flutter/material.dart';

/// Bouton en couleur secondaire
class SecondaryButton extends StatelessWidget {
  /// Texte du bouton
  final String text;

  /// Action du bouton
  final void Function() onPressed;

  /// Constructeur
  const SecondaryButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
      ),
    );
  }
}
