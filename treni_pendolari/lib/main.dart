import 'package:flutter/material.dart';
import 'package:treni_pendolari/configs/app_theme.dart';
import 'package:treni_pendolari/injection.dart';
import 'package:treni_pendolari/presentation/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const Scaffold(body: SplashPage()),
    );
  }
}
