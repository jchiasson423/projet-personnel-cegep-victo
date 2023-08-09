// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:eventify/eventify.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget pour afficher le solde du budget
class BalanceWidget extends StatefulWidget {
  /// Solde
  final double balance;

  /// Solde reçu
  final double receivedBalance;

  /// Largeur
  final double width;

  /// Est-ce le budget courant
  final bool isCurrent;

  /// Constructeur
  const BalanceWidget({
    super.key,
    required this.balance,
    required this.receivedBalance,
    required this.width,
    this.isCurrent = false,
  });

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  late double balance;
  late double receivedBalance;

  @override
  void initState() {
    super.initState();
    balance = widget.balance;
    receivedBalance = widget.receivedBalance;
    EventService.emitter.on('refresh/balance', context, refreshBalance);
  }

  @override
  void dispose() {
    EventService.emitter.removeAllByCallback(refreshBalance);
    super.dispose();
  }

  refreshBalance(Event event, _) {
    var newBalance = event.eventData as (double, double);
    setState(() {
      balance = newBalance.$1;
      receivedBalance = newBalance.$2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 75,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Titre
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(AppLocalizations.of(context)!.budget_balance,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary)),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Solde
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: Text(
                      NumberFormat.simpleCurrency().format(balance),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  // Solde reçu affiché si c'est le budget courant
                  if (widget.isCurrent)
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Text(
                        NumberFormat.simpleCurrency().format(receivedBalance),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
