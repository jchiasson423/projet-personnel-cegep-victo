import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire d'inscription par courriel
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>();

  /// Nom de l'utilisateur
  String name = '';

  /// Courriel de l'utilisateur
  String email = '';

  /// Mot de passe de l'utilisateur
  String password = '';

  /// Confirmation du mot de passe de l'utilisateur
  String confirmPassword = '';

  /// Erreur
  String error = '';

  /// Enregistre l'utilisateur
  Future login() async {
    // Documente moi tout le code en dessous selon ce qu'il fait en français

    // Validation du formulaire
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Reset des erreurs
    await Future.delayed(Duration.zero);
    error = '';
    setState(() {});

    try {
      // Enregistrement de l'utilisateur
      await AuthService.registerUser(
        email,
        password,
        displayName: name,
      );
    } catch (e) {
      // En cas d'erreur, on affiche l'erreur
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      error = AppLocalizations.of(context)!.email_sign_in_failed;
      setState(() {});
      return;
    }

    // En cas de succès, on redirige l'utilisateur vers la page d'accueil
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
              // Formulaire d'inscription
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Titre
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.email_register_message,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    // Nom
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.name],
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .general_display_name,
                          hintText: AppLocalizations.of(context)!
                              .general_display_name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Validation du nom
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .display_name_empty;
                          }
                          return null;
                        },
                        initialValue: name,
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    // Courriel
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.general_email,
                          hintText: AppLocalizations.of(context)!.general_email,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Validation du courriel
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
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.general_password,
                          hintText:
                              AppLocalizations.of(context)!.general_password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Validation du mot de passe
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
                    // Confirmation du mot de passe
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .general_confirm_password,
                          hintText: AppLocalizations.of(context)!
                              .general_confirm_password,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Validation de la confirmation du mot de passe
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .password_confirm_empty;
                          }

                          if (value != password) {
                            return AppLocalizations.of(context)!
                                .password_confirm_invalid;
                          }

                          return null;
                        },
                        initialValue: confirmPassword,
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                      ),
                    ),
                    // Erreur
                    Text(
                      error,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Theme.of(context).colorScheme.error),
                    ),
                    // Bouton d'inscription
                    PrimaryButton(
                      text: AppLocalizations.of(context)!.email_register,
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
