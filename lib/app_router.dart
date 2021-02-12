import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:smartgreenhouse_app/home/home.dart';
import 'package:smartgreenhouse_app/login/login.dart';
import 'package:smartgreenhouse_app/particle_cloud/particle_cloud.dart';
import 'package:smartgreenhouse_app/particles/particles.dart';
import 'package:smartgreenhouse_app/reports/reports.dart';
import 'package:smartgreenhouse_app/rules/rules.dart';
import 'package:smartgreenhouse_app/settings/settings.dart';
import 'package:smartgreenhouse_app/sign_up/sign_up.dart';
import 'package:smartgreenhouse_app/splash/splash.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const particles = '/particles';
  static const reports = '/reports';
  static const rules = '/rules';
  static const settings = '/settings';
  static const particleCloud = '/cloud';
}

// TODO Switch to Router 2.0
class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    dev.log('Navigate to ${settings.name}', name: 'AppRouter');

    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
        );
      case AppRoutes.home:
        return PageRouteBuilder<MaterialPageRoute>(
          pageBuilder: (_, __, ___) => HomePage(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppRoutes.particles:
        return PageRouteBuilder<MaterialPageRoute>(
          pageBuilder: (_, __, ___) => ParticlesPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppRoutes.reports:
        return PageRouteBuilder<MaterialPageRoute>(
          pageBuilder: (_, __, ___) => ReportsPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppRoutes.rules:
        return PageRouteBuilder<MaterialPageRoute>(
          pageBuilder: (_, __, ___) => RulesPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppRoutes.settings:
        return PageRouteBuilder<MaterialPageRoute>(
          pageBuilder: (_, __, ___) => SettingsPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppRoutes.particleCloud:
        return MaterialPageRoute(
          builder: (_) => ParticleCloudPage(
            isLinked: settings.arguments as bool,
          ),
        );
      case AppRoutes.splash:
      default:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
    }
  }
}
