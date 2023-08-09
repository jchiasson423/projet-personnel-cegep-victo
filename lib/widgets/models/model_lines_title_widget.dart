// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Titre des lignes de modèle
class ModelLinesTitle extends StatefulWidget {
  /// Largeur
  final double width;

  /// Couleur
  final Color color;

  /// Couleur du texte
  final Color textColor;

  /// Constructeur
  const ModelLinesTitle({
    super.key,
    required this.width,
    required this.color,
    required this.textColor,
  });

  @override
  State<ModelLinesTitle> createState() => _ModelLinesTitleState();
}

class _ModelLinesTitleState extends State<ModelLinesTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: widget.color,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Titre ligne
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.budget_line_name,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: widget.textColor,
                            ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Titre prévu
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            AppLocalizations.of(context)!.budget_foreseen,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: widget.textColor,
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
