// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Dialogue pour créer un modèle
class ModelCreateDialog extends StatefulWidget {
  const ModelCreateDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ModelCreateDialog> createState() => _ModelCreateDialogState();
}

class _ModelCreateDialogState extends State<ModelCreateDialog> {
  /// Clé du formulaire
  final formKey = GlobalKey<FormState>();

  /// Nom du modèle
  String name = '';

  /// Sauvegarde le modèle
  saveModel() async {
    // Vérifie que le formulaire est valide
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Crée le modèle
    var model = await Services.models.create(Model(name: name));

    // Navigue vers le modèle
    // ignore: use_build_context_synchronously
    context.beamToNamed('/dashboard/model/${model.id}');

    // Ferme le dialogue
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.model_create,
          style: Theme.of(context).textTheme.titleLarge),
      // Formulaire
      content: Form(
        key: formKey,

        // Champ de texte pour le nom du modèle
        child: TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.model_name,
            hintText: AppLocalizations.of(context)!.model_name,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          initialValue: name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.model_name_empty;
            }
            return null;
          },
          onChanged: (value) {
            name = value;
          },
        ),
      ),
      actions: [
        // Bouton annuler
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(AppLocalizations.of(context)!.general_cancel)),

        // Bouton sauvegarder
        PrimaryButton(
          onPressed: () {
            saveModel();
          },
          text: AppLocalizations.of(context)!.general_save,
        ),
      ],
    );
  }
}
