import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/buttons/secondary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire pour modifier le nom d'utilisateur
class ProfileNameForm extends StatefulWidget {
  /// Constructeur
  const ProfileNameForm({
    super.key,
  });

  @override
  State<ProfileNameForm> createState() => _ProfileNameFormState();
}

class _ProfileNameFormState extends State<ProfileNameForm> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'profile_name_form');

  /// Utilisateur courant
  late User user;

  /// Nom d'utilisateur
  String oldDisplayName = '';

  /// Ancien nom d'utilisateur
  static String displayName = '';

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    user = AuthService.getCurrentUser()!;
    displayName = user.displayName ?? '';
    oldDisplayName = displayName;
  }

  /// Sauvegarde le nom
  saveName() async {
    // Vérifie que le formulaire est valide
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Sauvegarde le nom
    oldDisplayName = displayName;
    setState(() {});

    await AuthService.updateDisplayName(
      displayName,
    );

    // Envoie l'événement de changement de nom
    EventService.emitter.emit(
      'display_name/changed',
      this,
      displayName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            // Formulaire
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Titre
                      Text(
                        AppLocalizations.of(context)!.general_display_name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      // Boutons d'action (sauvegarde et annulation) si le nom a changé
                      if (displayName != oldDisplayName)
                        Row(
                          children: [
                            PrimaryButton(
                              onPressed: saveName,
                              text: AppLocalizations.of(context)!.general_save,
                            ),
                            SecondaryButton(
                              text:
                                  AppLocalizations.of(context)!.general_cancel,
                              onPressed: () {
                                displayName = user.displayName ?? '';
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                    ],
                  ),

                  // Champ de texte pour le nom d'utilisateur
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!
                              .general_display_name,
                          hintText: AppLocalizations.of(context)!
                              .general_display_name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      initialValue: displayName,

                      // Vérifie que le nom n'est pas vide
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!
                              .display_name_empty;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        displayName = value;
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
