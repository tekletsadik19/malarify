import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:malarify/features/auth/presentation/auth_view.dart';
import '../../features/auth/controller/authentication_controller.dart';
import '../../features/home/presentation/homepage.dart';
import '../../features/onboarding/landing.dart';




final routerProvider = Provider(
      (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/temari-hebret',
        builder: (context, state) =>  Landing(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) =>
            AuthViewPage(
              showSignIn: state.extra!=null?state.extra as bool:false,
            ),
      ),
    ],
    redirect: (_, state) {
      final authenticationState = ref.read(authProvider);
      final fromParam = (authenticationState.status == AuthenticationStatus.authenticated) ? '' : '?from=${state.matchedLocation}';
      if(authenticationState.status == AuthenticationStatus.authenticated){
        return state.matchedLocation == '/' ? null : '/';
      }
      if(authenticationState.status != AuthenticationStatus.authenticated){
        if(state.matchedLocation == '/auth'){
          return state.matchedLocation == '/auth' ? null : '/auth';
        }
        return state.matchedLocation == '/temari-hebret' ? null : '/temari-hebret';
      }

      return null;
    },
  ),
);
