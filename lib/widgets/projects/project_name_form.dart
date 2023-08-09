import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire pour modifier le nom du projet
class ProjectNameForm extends StatefulWidget {
  /// Nom du projet
  final String name;

  /// Callback lors du changement
  final Function(String newName) onChange;

  /// Constructeur
  const ProjectNameForm({
    super.key,
    required this.name,
    required this.onChange,
  });

  @override
  State<ProjectNameForm> createState() => _ProjectNameFormState();
}

class _ProjectNameFormState extends State<ProjectNameForm> {
  /// Nom du projet
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
                      AppLocalizations.of(context)!.project_name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Nom du projet
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.project_name,
                        hintText: AppLocalizations.of(context)!.project_name,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    initialValue: name,

                    // Validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.project_name_empty;
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
