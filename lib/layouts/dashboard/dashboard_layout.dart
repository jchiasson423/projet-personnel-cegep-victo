import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/config/delegates/dashboard_delegate.dart';
import 'package:budget_maker_app/utilities/enums.dart';
import 'package:budget_maker_app/utilities/services/auth_service.dart';
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/widgets/dialogs/easter_egg_dialog.dart';
import 'package:budget_maker_app/widgets/economy_code_action.dart';
import 'package:budget_maker_app/widgets/logo/logo_widget.dart';
import 'package:budget_maker_app/widgets/profile/profile_picture.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:eventify/eventify.dart';

/// Interface de la page d'accueil du tableau de bord
class DashboardLayout extends StatefulWidget {
  const DashboardLayout({
    super.key,
  });

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  /// Délegate pour la navigation
  final _delegate = dashboardDelegate();

  /// Clé pour le Beamer
  final _beamerKey = const ValueKey('dashboard-beamer');

  /// Nom d'affichage de l'utilisateur
  String displayName = '';

  /// Initialise l'état
  @override
  void initState() {
    super.initState();
    var user = AuthService.getCurrentUser()!;
    displayName = user.displayName ?? 'Anonymous';

    /// Ajoute un écouteur pour le changement du nom d'affichage
    EventService.emitter.on('display_name/changed', context, changeDisplayName);
  }

  /// Libère les ressources
  @override
  void dispose() {
    EventService.emitter.removeAllByCallback(changeDisplayName);
    super.dispose();
  }

  /// Change le nom d'affichage
  changeDisplayName(Event evendData, _) {
    displayName = evendData.eventData as String;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Va chercher l'utilisateur courant
    var user = AuthService.getCurrentUser()!;
    return Scaffold(
      extendBody: true,
      // extendBodyBehindAppBar: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              // Gestionnaire de mouvements pour l'easter egg
              child: EconomyCodeAction(
                gestures: const [
                  GestureType.horizontalDrag,
                  GestureType.verticalDrag,
                  GestureType.tap,
                  GestureType.doubleTap,
                ],
                onAction: () {
                  // Affiche le dialogue de l'easter egg
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const EasterEggDialog();
                    },
                  );
                },
                // Beamer pour la navigation
                child: Beamer(
                  routerDelegate: _delegate,
                  key: _beamerKey,
                ),
              ),
            ),
            // En-tête de la page
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: kIsWeb ? 8 : 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Logo
                        InkWell(
                          onTap: () {
                            context.beamToNamed('/dashboard/home');
                          },
                          child: const Logo(
                            width: 60,
                            height: 60,
                          ),
                        ),
                        // Nom d'affichage
                        Text(
                          displayName,
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                    // Image de profil
                    ProfilePicture(
                      displayName: displayName,
                      photoURL: user.photoURL,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
