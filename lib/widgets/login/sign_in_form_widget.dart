import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/password_forgotten_dialog.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire de connexion par email
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>();

  /// Courriel
  String email = '';

  /// Mot de passe
  String password = '';

  /// Erreur
  String error = '';

  /// Connexion de l'utilisateur
  Future login() async {
    // Vérifie que le formulaire est valide
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Enlève les erreurs
    await Future.delayed(Duration.zero);
    error = '';
    setState(() {});

    try {
      // Tente de connecter l'utilisateur
      await AuthService.signInWithPassword(email, password);
    } catch (e) {
      // En cas d'erreur, affiche l'erreur
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      error = AppLocalizations.of(context)!.email_sign_in_failed;
      setState(() {});
      return;
    }

    // En cas de succès, redirige l'utilisateur vers la page d'accueil
    mainDelegate.beamToReplacementNamed('/dashboard/home');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // Formulaire de connexion
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Courriel
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.general_email,
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
                    ),
                    // Mot de passe
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.general_password,
                          hintText:
                              AppLocalizations.of(context)!.general_password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Vérifie que le mot de passe est valide
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.password_empty;
                          }

                          return null;
                        },
                        initialValue: password,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    // Bouton pour réinitialiser le mot de passe
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const PasswordForgottenDialog();
                          },
                        );
                      },
                      child: Text(
                          AppLocalizations.of(context)!.password_forgotten),
                    ),
                    // Erreur
                    Text(
                      error,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                    // Bouton de connexion
                    PrimaryButton(
                      text: AppLocalizations.of(context)!.email_sign_in,
                      onPressed: () async {
                        await login();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
