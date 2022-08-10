import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/dark-mode.dart';
import 'package:notes/secreen/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // runApp(MyApp());
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/langs', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool isDark = false;

  // changeTheme(bool value) {
  //   isDark = value;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkMode>(create: (context) {
      return DarkMode();
    }, builder: (context, child) {
      return MaterialApp(
        theme: Provider.of<DarkMode>(context).isDark
            ? ThemeData.dark()
            : ThemeData.light(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Home(),
      );
    });
  }
}
