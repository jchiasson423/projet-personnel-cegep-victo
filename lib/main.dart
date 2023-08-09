import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/config/delegates/main_delegate.dart';
import 'package:budget_maker_app/firebase_options.dart';
import 'package:budget_maker_app/theme/theme.dart';
import 'package:budget_maker_app/utilities/services/brigthness_service.dart';
import 'package:budget_maker_app/utilities/services/events_service.dart';
import 'package:budget_maker_app/utilities/services/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Point d'entrée de l'application
void main() async {
  // Enlève le # de l'url
  Beamer.setPathUrlStrategy();

  // Initialise les widgets
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialise le stockage local
  await LocalStorage.init();

  // Lance l'application
  runApp(
    const BudgetMakerApp(),
  );
}

/// Application
class BudgetMakerApp extends StatefulWidget {
  /// Constructeur
  const BudgetMakerApp({
    super.key,
  });

  @override
  State<BudgetMakerApp> createState() => _BudgetMakerAppState();
}

class _BudgetMakerAppState extends State<BudgetMakerApp> {
  /// Initialise l'état
  @override
  void initState() {
    super.initState();

    // Rafraîchit le thème lorsque l'événement est reçu
    EventService.emitter.on('brightness/changed', context, changeBrightness);
  }

  /// Libère les ressources
  @override
  void dispose() {
    EventService.emitter.removeAllByCallback(changeBrightness);
    super.dispose();
  }

  /// Rafraîchit le thème
  changeBrightness(_, __) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Application avec navigation
    return MaterialApp.router(
      // Ma navigation Beamer gère le retour arrière
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: mainDelegate,
      ),

      // Enlève le bandeau de debug
      debugShowCheckedModeBanner: false,

      // Langues supportées
      supportedLocales: const [
        Locale('fr', ''),
        Locale('en', ''),
      ],
      locale: const Locale('fr', ''),

      // Gestionnaires de traduction
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Gestionnaire de navigation
      routeInformationParser: BeamerParser(),
      routerDelegate: mainDelegate,
      builder: (context, child) {
        if (child != null) {
          final themeProvider = ThemeProvider();

          // Retourne l'application chargée avec le thème correspondant à la luminosité
          return Theme(
            data: themeProvider.getFrom(
              BrightnessService.getCurrentBrightness(context),
            ),
            child: child,
          );
        }
        return Container();
      },
    );
  }
}
