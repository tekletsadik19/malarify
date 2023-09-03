import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/app_theme/constants.dart';
import 'core/utils/strings.dart';
import 'features/edu_gen/bloc/app_directory_cubit.dart';
import 'features/edu_gen/bloc/app_language_cubit.dart';
import 'features/edu_gen/data/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'core/route/app_route.dart';
import '../core/utils/theme_notifier.dart';
import '../../features/auth/controller/authentication_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://378a6836de9e3229597776273a07b2c3@o4505814896148480.ingest.sentry.io/4505814897983488';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const ProviderScope(child: MyApp())),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _themeNotifier = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);

    ref.listen(authProvider, (_, __) {
      router.refresh();
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppLanguageCubit(const Locale(englishLanguage, 'US'))
            ..loadLanguage(),
        ),
        BlocProvider(
          create: (_) => AppDirectoryCubit(pathHint)..loadPath(),
        ),
      ],
      child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
        builder: (context, language) {
          return Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: language.locale,
              routeInformationParser:
                  ref.read(routerProvider).routeInformationParser,
              routerDelegate: ref.read(routerProvider).routerDelegate,
              routeInformationProvider:
                  ref.read(routerProvider).routeInformationProvider,
              title: 'Malarify',
              themeMode: _themeNotifier.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
