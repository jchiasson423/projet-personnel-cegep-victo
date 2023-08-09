import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/layouts/dashboard/pages/budget_page.dart';
import 'package:budget_maker_app/layouts/dashboard/pages/home_page.dart';
import 'package:budget_maker_app/layouts/dashboard/pages/model_page.dart';
import 'package:budget_maker_app/layouts/dashboard/pages/profile_page.dart';
import 'package:budget_maker_app/layouts/dashboard/pages/project_page.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/budget_guard.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/model_guard.dart';
import 'package:budget_maker_app/utilities/guards/entity_guards/project_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Responsable pour la navigation dans le dashboard
BeamerDelegate dashboardDelegate() {
  return BeamerDelegate(
    initialPath: '/dashboard/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // Page d'accueil
        '/dashboard/home': (context, state, data) {
          return BeamPage(
            key: const ValueKey('dashboard-home'),
            type: BeamPageType.slideLeftTransition,
            title: AppLocalizations.of(context)!.dashboard_home_title,
            child: const HomePage(),
          );
        },
        // Page de profil
        '/dashboard/profile': (context, state, data) {
          return BeamPage(
            key: const ValueKey('dashboard-profile'),
            type: BeamPageType.slideRightTransition,
            title:
                AppLocalizations.of(context)!.dashboard_account_settings_title,
            child: const ProfilePage(),
          );
        },
        // Page de modèle
        '/dashboard/model/:id': (context, state, data) {
          var id = state.pathParameters['id']!;
          return BeamPage(
              key: ValueKey('dashboard-model-$id'),
              type: BeamPageType.slideRightTransition,
              title: AppLocalizations.of(context)!.dashboard_model_title,
              child: ModelGuard(
                id: id,
                child: const ModelPage(),
              ));
        },
        // Page de budget
        '/dashboard/budget/:id': (context, state, data) {
          var id = state.pathParameters['id']!;
          return BeamPage(
              key: ValueKey('dashboard-budget-$id'),
              type: BeamPageType.slideRightTransition,
              title: AppLocalizations.of(context)!.dashboard_budget_title,
              child: BudgetGuard(
                id: id,
                child: const BudgetPage(),
              ));
        },
        // Page de projet
        '/dashboard/project/:id': (context, state, data) {
          var id = state.pathParameters['id']!;
          return BeamPage(
              key: ValueKey('dashboard-project-$id'),
              type: BeamPageType.slideRightTransition,
              title: AppLocalizations.of(context)!.dashboard_project_title,
              child: ProjectGuard(
                id: id,
                child: const ProjectPage(),
              ));
        },
      },
    ),
  );
}
