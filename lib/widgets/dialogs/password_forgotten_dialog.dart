// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Dialogue pour réinitialiser le mot de passe
class PasswordForgottenDialog extends StatefulWidget {
  const PasswordForgottenDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordForgottenDialog> createState() =>
      _PasswordForgottenDialogState();
}

class _PasswordForgottenDialogState extends State<PasswordForgottenDialog> {
  /// Email
  String email = '';

  /// Message
  String message = '';

  /// Couleur du message
  Color messageColor = Colors.green;

  /// Clé du formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'password_forgotten_form');

  /// Envoie le courriel
  sendEmail() async {
    // Réinitialise le message
    message = '';
    setState(() {});

    // Vérifie que le formulaire est valide
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Envoie le courriel
    try {
      await AuthService.sendResetPasswordEmail(email);
      // ignore: use_build_context_synchronously

      // Affiche le message de succès
      // ignore: use_build_context_synchronously
      message = AppLocalizations.of(context)!.password_email_sent;
      messageColor = Colors.green;
    } catch (e) {
      // Affiche le message d'erreur
      message = AppLocalizations.of(context)!.password_email_error;
      messageColor = Colors.red;
    }

    // Met à jour l'interface
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context)!.general_confirm_message;
    return AlertDialog(
      // Titre du dialogue
      title: Text(AppLocalizations.of(context)!.password_email_message,
          style: Theme.of(context).textTheme.titleLarge),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,

          // Formulaire
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Champ de texte pour le courriel
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.general_email,
                    hintText: AppLocalizations.of(context)!.general_email,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Vérifie que le courriel est valide
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.email_empty;
                    }
                    if (!EmailValidator.validate(value)) {
                      return AppLocalizations.of(context)!.email_invalid;
                    }
                    return null;
                  },
                  initialValue: email,
                  onChanged: (value) {
                    email = value;
                  },
                ),

                // Affiche le message
                if (message.isNotEmpty)
                  Text(
                    message,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: messageColor),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        // Bouton annuler
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.general_cancel)),

        // Bouton envoyer
        PrimaryButton(
          onPressed: () {
            sendEmail();
          },
          text: AppLocalizations.of(context)!.general_send,
        ),
      ],
    );
  }
}
