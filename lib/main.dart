import 'package:flutter/material.dart';
import 'package:servi_card/src/pages/home_page.dart';
import 'package:servi_card/src/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ServiCard',
      theme: AppTheme.themeData(true),
      home: const HomePage(),
    );
  }
}
