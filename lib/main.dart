import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/app_theme/constants.dart';
import 'firebase_options.dart';
import 'core/route/app_route.dart';
import '../core/utils/theme_notifier.dart';
import '../../features/auth/controller/authentication_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}


class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _themeNotifier = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);

    ref.listen(authProvider, (_, __) {
      router.refresh();
    });
    return MaterialApp.router(
      routeInformationParser: ref.read(routerProvider).routeInformationParser,
      routerDelegate: ref.read(routerProvider).routerDelegate,
      routeInformationProvider: ref.read(routerProvider).routeInformationProvider,
      title: 'Malarify',
      themeMode: _themeNotifier.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
