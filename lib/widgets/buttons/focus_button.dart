import 'package:flutter/material.dart';

/// Bouton en thème focus
class FocusButton extends StatelessWidget {
  /// Texte du bouton
  final String text;

  /// Action du bouton
  final void Function() onPressed;

  /// Constructeur
  const FocusButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}
