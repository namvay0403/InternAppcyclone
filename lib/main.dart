import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_appcyclone/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intern_appcyclone/utilities/providers/list_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'practice/week02/firebase/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'practice/week02/localization/bloc/localization_bloc/localization_bloc.dart';
import 'practice/week02/localization/bloc/theme_bloc/bloc/theme_bloc.dart';
import 'practice/week02/localization/model/theme.dart';
import 'practice/week03/rxdart/bloc/provider_user.dart';
import 'travel_app/pages/splash_page/splash_page.dart';
import 'utilities/const/route.dart';

// void main() {
//   runApp(const MyApp());
// }

late final prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuthService().initNotification();

  prefs = await SharedPreferences.getInstance();

  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(
    MultiBlocProvider(
      providers: listProvider,
      child: MyApp(
        onboarding: onboarding,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, required this.onboarding});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeMode>(
            builder: (context, state1) {
              return UserProvider(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('vi', 'VN'),
                    Locale('en', 'US'),
                  ],
                  locale: state.locale,
                  themeMode: state1,
                  home: SplashPage(onBoarding: onboarding),
                  onGenerateRoute: generateRoute,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
