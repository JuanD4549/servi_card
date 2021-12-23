import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/providers/provider.dart';
import 'package:servi_card/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool? mode;
  @override
  void initState() {
    super.initState();
    _setupMode();
  }

  @override
  Widget build(BuildContext context) {
    final bool modeValue = mode ?? false;
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ServiCard',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: modeValue ? Brightness.light : Brightness.dark),
        home: const HomePage(),
      ),
    );
  }

  _setupMode() async {
    final SharedPreferences prefs = await _prefs;
    mode = prefs.getBool("mode");
  }
}
