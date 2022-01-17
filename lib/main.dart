import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servi_card/src/pages/home_page.dart';
import 'package:servi_card/src/providers/main_provider.dart';
import 'package:servi_card/src/providers/pedido_provider.dart';
import 'package:servi_card/src/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PedidoProvider()),
    ChangeNotifierProvider(create: (_) => MainProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
              builder: () => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.themeData(mainProvider.mode),
                home: const HomePage(),
              ),
            );
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}
