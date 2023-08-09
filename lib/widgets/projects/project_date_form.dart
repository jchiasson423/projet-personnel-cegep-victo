import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulaire pour la date du projet
class ProjectDateForm extends StatefulWidget {
  /// Date du projet
  final DateTime date;

  /// Fonction à appeler lorsque la date change
  final Function(DateTime newDate) onChange;

  /// Constructeur
  const ProjectDateForm({
    super.key,
    required this.date,
    required this.onChange,
  });

  @override
  State<ProjectDateForm> createState() => _ProjectDateFormState();
}

class _ProjectDateFormState extends State<ProjectDateForm> {
  /// Date du projet
  late DateTime date;

  /// Contrôleur pour le champ de texte
  TextEditingController dateController = TextEditingController();

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    date = widget.date;
    dateController.text = DateFormat('yyyy-MM-dd').format(date);
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
                      AppLocalizations.of(context)!.project_target_date,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Champ de texte pour la date du projet
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.project_target_date,
                      hintText:
                          AppLocalizations.of(context)!.project_target_date,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    // Validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .project_target_date_empty;
                      }
                      return null;
                    },

                    // Affiche le calendrier lorsqu'on clique sur le champ
                    onTap: () async {
                      var newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      );
                      if (newDate == null) {
                        return;
                      }

                      date = DateTime(newDate.year, newDate.month, newDate.day);
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                      setState(() {});
                      widget.onChange(date);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
