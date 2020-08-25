import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home_page.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<HomePage>(
          builder: (_) => const HomePage(), );
        default:
          throw RouteException("Route not found");
    }
  }

  static const homePage = '/';
}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  final String message;
  const RouteException( this.message);
}