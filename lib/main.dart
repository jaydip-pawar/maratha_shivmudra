import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:maratha_shivmudra/core/di/di.dart';
import 'package:maratha_shivmudra/core/l10n/generated/l10n.dart';
import 'package:maratha_shivmudra/core/routes/route_config.dart';
import 'package:maratha_shivmudra/firebase_options.dart';

import 'package:maratha_shivmudra/core/constants/assets.dart';
import 'package:maratha_shivmudra/core/constants/styles.dart';
import 'package:maratha_shivmudra/core/utils/colors.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(AppAssets.oflFontLicense);
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  setUrlStrategy(PathUrlStrategy());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencyInjection();
  runApp(const MyApp());
}

final ValueNotifier<Locale> appLocaleNotifier =
    ValueNotifier<Locale>(const Locale('mr', ''));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, child) {
        return MaterialApp.router(
          title: 'मराठा शिवमुद्रा प्रतिष्ठान',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: AppTypography.fontFamily,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.darkBg,
            colorScheme: const ColorScheme.dark(
              primary: AppColors.saffron,
              secondary: AppColors.gold,
              surface: AppColors.darkSurface,
            ),
            useMaterial3: true,
          ),
          routerConfig: _appRouter.config(
            includePrefixMatches: true,
          ),
          supportedLocales: const [
            Locale('mr', ''),
            Locale('en', ''),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          locale: locale,
        );
      },
    );
  }
}
