import 'package:budget_maker_app/utilities/entities/project_entity.dart';
import 'package:budget_maker_app/widgets/base_carousel_widget.dart';
import 'package:budget_maker_app/widgets/buttons/primary_button.dart';
import 'package:budget_maker_app/widgets/projects/project_card_widget.dart';
import 'package:budget_maker_app/widgets/dialogs/project_create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Carrousel des projets
class ProjectCarousel extends StatefulWidget {
  /// Future pour récupérer les projets
  final Future<List<Project>> Function() future;

  /// Callback lors de la suppression
  final Function(Project project) onDelete;

  /// Constructeur
  const ProjectCarousel({
    super.key,
    required this.future,
    required this.onDelete,
  });

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
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

        var projects = snapshot.data!;
        List<Widget> items = [];

        // Ajoute les cartes des projets
        for (var project in projects) {
          items.add(
            ProjectCard(
              project: project,
              onDelete: (project) {
                widget.onDelete(project);
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
                    AppLocalizations.of(context)!.projects_title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  // Bouton pour créer un projet
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.project_create,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ProjectCreateDialog(),
                      );
                    },
                  ),
                ],
              ),

              // Carrousel
              BaseCarousel(
                noResultMessage:
                    AppLocalizations.of(context)!.project_no_result,
                items: items,
              ),
            ],
          ),
        );
      },
    );
  }
}
