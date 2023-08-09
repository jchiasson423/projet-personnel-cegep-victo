import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Bouton de connexion avec Google
class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  /// Message d'erreur
  String error = '';

  /// Fonction de connexion avec Google
  Future login() async {
    // Wait pour laisser le temps à l'app de rafraîchir
    await Future.delayed(Duration.zero);

    // Reset des erreurs
    error = '';
    setState(() {});
    try {
      // Connexion avec Google
      await AuthService.signInWithGoogle();
    } catch (e) {
      // Wait pour laisser le temps à l'app de rafraîchir
      await Future.delayed(Duration.zero);

      // Affichage de l'erreur
      // ignore: use_build_context_synchronously
      error = AppLocalizations.of(context)!.google_sign_in_failed;
      setState(() {});
      return;
    }

    // Redirection vers la page d'accueil
    mainDelegate.beamToReplacementNamed('/dashboard/home');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(builder: (context, constraints) {
          // Bouton de connexion
          return InkWell(
            onTap: () async {
              await login();
            },
            child: Container(
              width: constraints.maxWidth,
              height: 100,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google-logo.png',
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.google_sign_in,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    if (error.isNotEmpty)
                      Text(
                        error,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      )
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
