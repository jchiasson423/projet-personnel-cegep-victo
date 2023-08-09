import 'package:budget_maker_app/utilities/entities/model_entity.dart';
import 'package:budget_maker_app/widgets/base_carousel_widget.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/dialogs/model_create_dialog.dart';
import 'package:budget_maker_app/widgets/models/model_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Carrousel des modèles
class ModelCarousel extends StatefulWidget {
  /// Future pour récupérer les modèles
  final Future<List<Model>> Function() future;

  /// Constructeur
  const ModelCarousel({
    super.key,
    required this.future,
  });

  @override
  State<ModelCarousel> createState() => _ModelCarouselState();
}

class _ModelCarouselState extends State<ModelCarousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Model>>(
      future: widget.future(),
      builder: (context, snapshot) {
        // Affiche un indicateur de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Affiche une erreur
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox(
            height: 350,
            child: Text('Error'),
          );
        }

        var models = snapshot.data!;
        List<Widget> items = [];

        // Ajoute les cartes des modèles
        for (var model in models) {
          items.add(
            ModelCard(
              model: model,
              onDelete: (budget) {
                setState(() {});
              },
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Titre
                  Text(
                    AppLocalizations.of(context)!.models_title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  // Bouton pour créer un modèle
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.model_create,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ModelCreateDialog(),
                      );
                    },
                  ),
                ],
              ),

              // Carrousel
              BaseCarousel(
                noResultMessage: AppLocalizations.of(context)!.model_no_result,
                items: items,
              ),
            ],
          ),
        );
      },
    );
  }
}
