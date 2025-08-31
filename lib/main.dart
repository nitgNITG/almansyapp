import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:step/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:step/app/core/themes/light_theme.dart';
import 'package:step/app/modules/course_categories/course_categories_page.dart';
import 'package:step/app/modules/splash/splash_page.dart';
import 'package:step/app/widgets/get_size_config.dart';
import 'package:step/global_providers/localization_provider.dart';
import 'app/modules/home_page/home_controller.dart';

import 'global_providers/theme_provider.dart';

/// created with respect Ahmed Ashraf in nitg company

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeMain();

  runApp(
    const MyApp(),
  );
}

final getIt = GetIt.instance;

initializeMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();
  getIt.registerSingleton<HomeController>(HomeController());
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationProvider>(
          create: (_) => LocalizationProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
      ],
      builder: (context, child) => ScreenUtilInit(
        designSize: getResponsiveSize(context),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'almansy academy',
            themeMode: ThemeMode.light,
            locale: const Locale('ar'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale("ar"),
            ],
            theme: getLightThemeData(),
            routes: Map.from({
              CourseCategoriesPage.name: (context) =>
                  const CourseCategoriesPage(),
            }),
            home: Builder(builder: (context) {
              return const SplashPage();
            }),
          );
        },
      ),
    );
  }
}
