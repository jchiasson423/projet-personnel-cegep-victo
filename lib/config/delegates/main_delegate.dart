import 'package:beamer/beamer.dart';
import 'package:budget_maker_app/layouts/auth/auth_layout.dart';
import 'package:budget_maker_app/layouts/dashboard/dashboard_layout.dart';
import 'package:budget_maker_app/utilities/guards/auth_guard.dart';
import 'package:flutter/material.dart';

// Responsable principal de la navigation
BeamerDelegate mainDelegate = BeamerDelegate(
  initialPath: '/dashboard/home',
  notFoundRedirectNamed: "/auth/login",
  locationBuilder: RoutesLocationBuilder(
    routes: {
      // Routes du dashboard
      '/dashboard/*': (context, state, data) {
        return const BeamPage(
            key: ValueKey('dashboard-delegate'),
            type: BeamPageType.fadeTransition,
            title: 'Dashboard',
            child: AuthGuard(
              child: DashboardLayout(
                key: ValueKey('dashboard-delegate-widget'),
              ),
            ));
      },
      // Routes de connexion
      '/auth/*': (context, state, data) {
        return const BeamPage(
          key: ValueKey('auth-delegate'),
          type: BeamPageType.fadeTransition,
          title: 'Auth',
          child: AuthLayout(
            key: ValueKey('auth-delegate-widget'),
          ),
        );
      },
    },
  ),
);
