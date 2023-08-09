// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Dialogue de confirmation
/// Retourne vrai si l'utilisateur a confirmé
class ConfirmDialog extends StatefulWidget {
  /// Message
  final String? message;

  /// Afficher le bouton annuler
  final bool showCancel;

  /// Constructeur
  const ConfirmDialog({
    Key? key,
    this.message,
    this.showCancel = true,
  }) : super(key: key);

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  // Message
  String message = "";

  @override
  Widget build(BuildContext context) {
    // Détermine le message
    message =
        widget.message ?? AppLocalizations.of(context)!.general_confirm_message;
    return AlertDialog(
      // Titre du dialogue (message)
      title: Text(message, style: Theme.of(context).textTheme.titleLarge),
      actions: [
        // Bouton annuler
        if (widget.showCancel)
          TextButton(
              onPressed: () {
                // Retourne faux (annuler)
                Navigator.pop(context, false);
              },
              child: Text(AppLocalizations.of(context)!.general_cancel)),

        // Bouton OK
        PrimaryButton(
          onPressed: () {
            // Retourne vrai (OK)
            Navigator.pop(context, true);
          },
          text: AppLocalizations.of(context)!.general_ok,
        ),
      ],
    );
  }
}
