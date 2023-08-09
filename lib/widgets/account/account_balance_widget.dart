import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/utilities/services/database/services.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/buttons/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget pour afficher le solde du compte
class AccountBalance extends StatefulWidget {
  /// Solde du compte
  final double balance;

  /// Constructeur
  const AccountBalance({
    super.key,
    required this.balance,
  });

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  /// Clé du formulaire
  var formKey = GlobalKey<FormState>(debugLabel: 'account_form');

  /// Ancien solde
  late double oldBalance;

  /// Solde
  late double balance;

  /// Initialise le widget
  @override
  void initState() {
    super.initState();
    balance = widget.balance;
    oldBalance = balance;
  }

  /// Sauvegarde le solde
  saveBalance() async {
    // Si le formulaire n'est pas valide, retourne
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Sauvegarde le solde
    oldBalance = balance;
    setState(() {});

    await Services.account.setBalance(balance);

    // Émet l'événement de changement de compte
    EventService.emitter.emit(
      'account/changed',
      this,
      balance,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Titre
                    Text(
                      AppLocalizations.of(context)!.account_section,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    // Boutons affichés si le solde a changé
                    if (balance != oldBalance)
                      Row(
                        children: [
                          PrimaryButton(
                            onPressed: saveBalance,
                            text: AppLocalizations.of(context)!.general_save,
                          ),
                          SecondaryButton(
                            text: AppLocalizations.of(context)!.general_cancel,
                            onPressed: () {
                              balance = oldBalance;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                  ],
                ),

                // Formulaire de solde
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: balance.toStringAsFixed(2),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        // Valide le solde
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!
                                .account_balance_empty;
                          }
                          if (double.tryParse(value) == null) {
                            return AppLocalizations.of(context)!
                                .account_balance_invalid;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.account_balance,
                          hintText:
                              AppLocalizations.of(context)!.account_balance,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixText: '\$',
                        ),
                        onChanged: (value) {
                          balance = double.tryParse(value) ?? 0;
                          setState(() {});
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
