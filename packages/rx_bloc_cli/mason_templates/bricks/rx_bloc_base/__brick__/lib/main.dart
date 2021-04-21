import 'package:flutter/material.dart';
import 'package:{{project_name}}/base/app/environment_config.dart';
import 'package:{{project_name}}/base/app/my_app.dart';

/// Main entry point for the production environment
void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.dev/testing/ for more info.
  // enableFlutterDriverExtension();

  runApp({{#pascalCase}}{{project_name}}{{/pascalCase}}(config: EnvironmentConfig.prod));
}
