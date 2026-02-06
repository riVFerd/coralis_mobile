import 'package:flutter/material.dart';
import 'package:coralis_test/app.dart';
import 'package:coralis_test/injection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  await dotenv.load(fileName: ".env");
  runApp(const App());
}
