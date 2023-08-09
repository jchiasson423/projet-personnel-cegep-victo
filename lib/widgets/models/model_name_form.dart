import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire pour le nom du modèle
class ModelNameForm extends StatefulWidget {
  /// Nom du modèle
  final String name;

  /// Fonction à appeler lorsque le nom change
  final Function(String newName) onChange;

  /// Constructeur
  const ModelNameForm({
    super.key,
    required this.name,
    required this.onChange,
  });

  @override
  State<ModelNameForm> createState() => _ModelNameFormState();
}

class _ModelNameFormState extends State<ModelNameForm> {
  /// Nom du modèle
  String name = '';

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    name = widget.name;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Titre
                    Text(
                      AppLocalizations.of(context)!.model_name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Champ de texte pour le nom du modèle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.model_name,
                        hintText: AppLocalizations.of(context)!.model_name,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    initialValue: name,

                    // Vérifie que le nom n'est pas vide
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.model_name_empty;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                      widget.onChange(name);
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
