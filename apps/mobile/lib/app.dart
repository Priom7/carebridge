import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/navigation/app_router.dart';
import 'core/settings/app_settings.dart';
import 'core/theme/carebridge_theme.dart';
import 'l10n/app_localizations.dart';

class CareBridgeApp extends StatefulWidget {
  const CareBridgeApp({this.initiallyAuthenticated = false, super.key});

  final bool initiallyAuthenticated;

  @override
  State<CareBridgeApp> createState() => _CareBridgeAppState();
}

class _CareBridgeAppState extends State<CareBridgeApp> {
  late final AppSettings settings;
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    settings = AppSettings(
      initiallyAuthenticated: widget.initiallyAuthenticated,
    );
    router = createAppRouter(settings);
  }

  @override
  void dispose() {
    router.dispose();
    settings.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => MaterialApp.router(
        title: 'CareBridge',
        debugShowCheckedModeBanner: false,
        theme: CareBridgeTheme.light,
        darkTheme: CareBridgeTheme.dark,
        themeMode: settings.themeMode,
        locale: settings.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
        builder: (context, child) {
          final media = MediaQuery.of(context);
          return MediaQuery(
            data: media.copyWith(
              textScaler: TextScaler.linear(settings.textScale),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
