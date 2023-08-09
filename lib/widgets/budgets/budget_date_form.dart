import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formulaire pour la date du budget
class BudgetDateForm extends StatefulWidget {
  // Nom du formulaire
  final String name;

  // Message à afficher lorsqu'il n'y a pas de données
  final String noDataMessage;

  /// Date du budget
  final DateTime date;

  // Date de début pour le formulaire
  final DateTime? startDate;

  // Date de fin pour le formulaire
  final DateTime? endDate;

  /// Fonction à appeler lorsque la date change
  final Function(DateTime newDate) onChange;

  /// Constructeur
  const BudgetDateForm({
    super.key,
    required this.name,
    required this.noDataMessage,
    required this.date,
    this.startDate,
    this.endDate,
    required this.onChange,
  });

  @override
  State<BudgetDateForm> createState() => _BudgetDateFormState();
}

class _BudgetDateFormState extends State<BudgetDateForm> {
  /// Date du budget
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
                      widget.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Champ de texte pour la date du budget
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: widget.name,
                      hintText: widget.name,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    // Validation
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.noDataMessage;
                      }
                      return null;
                    },

                    // Affiche le calendrier lorsqu'on clique sur le champ
                    onTap: () async {
                      var newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: widget.startDate ?? DateTime(2000),
                        lastDate: widget.endDate ?? DateTime(3000),
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
