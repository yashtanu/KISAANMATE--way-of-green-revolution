import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kisaanmate/screens/analysis.dart';
import 'package:kisaanmate/screens/camera.dart';
import 'package:kisaanmate/screens/home.dart';
import 'package:kisaanmate/screens/login.dart';
// import 'package:kisaanmate/screens/otp.dart';
import 'package:kisaanmate/services/localization/app_translations_delegate.dart';
import 'package:kisaanmate/services/localization/application.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color =
{
  50:Color.fromRGBO(148, 205, 72, .1),
  100:Color.fromRGBO(148, 205, 72, .2),
  200:Color.fromRGBO(148, 205, 72, .3),
  300:Color.fromRGBO(148, 205, 72, .4),
  400:Color.fromRGBO(148, 205, 72, .5),
  500:Color.fromRGBO(148, 205, 72, .6),
  600:Color.fromRGBO(148, 205, 72, .7),
  700:Color.fromRGBO(148, 205, 72, .8),
  800:Color.fromRGBO(148, 205, 72, .9),
  900:Color.fromRGBO(148, 205, 72, 1)
};

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    MaterialColor colorCustom = MaterialColor(0xFF94CD48, color);
    return MaterialApp(
      title: 'Kisaanmate',
      theme: ThemeData(
        primarySwatch: colorCustom,
        cursorColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "")
      ],
      initialRoute: '/',
      // ignore: missing_return
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => Login());
          case '/home':
            return MaterialPageRoute(
              builder: (context) => Home());
          case '/camera':
            return MaterialPageRoute(
              builder: (context) => Camera());
          case '/analysis':
            var arguments = settings.arguments;
            return MaterialPageRoute(
              builder: (context) => Analysis(argument: arguments));
        }
      }
      // routes: {
      //   '/': (context) => Login(),
      //   '/otp': (context) => OTP()
      // },
    );
  }
}
