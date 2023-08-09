import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Formulaire pour modifier le montant d'un projet
class ProjectAmountForm extends StatefulWidget {
  /// Montant
  final double amount;

  /// Titre
  final String title;

  /// String à afficher si le champ est vide
  final String emptyString;

  /// String à afficher si le champ est invalide
  final String invalidString;

  /// Fonction à appeler lorsque le montant change
  final Function(double newAmount) onChange;

  /// Constructeur
  const ProjectAmountForm({
    super.key,
    required this.amount,
    required this.title,
    required this.onChange,
    required this.emptyString,
    required this.invalidString,
  });

  @override
  State<ProjectAmountForm> createState() => _ProjectAmountFormState();
}

class _ProjectAmountFormState extends State<ProjectAmountForm> {
  /// Montant
  double amount = 0;

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    amount = widget.amount;
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
                // Titre
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),

                // Champ de texte pour le montant
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: amount.toStringAsFixed(2),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],

                    // Validation du champ de texte (doit être un nombre)
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return widget.emptyString;
                      }
                      if (double.tryParse(value) == null) {
                        return widget.invalidString;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: widget.title,
                      hintText: widget.title,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixText: '\$',
                    ),
                    onChanged: (value) {
                      amount = double.tryParse(value) ?? 0;
                      widget.onChange(amount);
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
