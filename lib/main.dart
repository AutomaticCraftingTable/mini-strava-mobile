import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_strava/routes/app_router.dart';

import 'components/language/app_localizations.dart';
import 'components/language/language_controller.dart';
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: LanguageController.instance,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Strava Project',

          locale: LanguageController.instance.locale,

          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: ThemeData(
            useMaterial3: true,
            colorScheme:
            ColorScheme.fromSeed(seedColor: const Color(0xFFFC4C02)),
          ),

          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
