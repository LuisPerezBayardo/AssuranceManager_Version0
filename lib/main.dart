import 'package:assurance/controllers/global_controller_usuario.dart';
import 'package:assurance/modules/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalControllerUsuario(), permanent: true);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
          title: 'Assurance Manager',
          smartManagement: SmartManagement.keepFactory,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            appBarTheme: AppBarTheme(foregroundColor: Colors.black),
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('es'),
          ],
          home: const SplashPage()),
    );
  }
}
