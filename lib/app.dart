import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'auth/auth_controller.dart';
import 'auth/screens/login_screen.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'scaffoldMessenger');
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  @override
  void initState() {
    super.initState();
    _router = _configureRouter();
  }

  GoRouter _configureRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      refreshListenable: context.read<AuthController>(),
      initialLocation: '/',
      routes: _configureRoutes(),
      redirect: _configureRedirect,
    );
  }

  String? _configureRedirect(BuildContext context, GoRouterState state) {
    final bool loggedIn =
        context.read<AuthController>().status == AuthStatus.authenticated;
    final bool loggingIn = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    }
    if (loggingIn) {
      return '/';
    }
    // no need to redirect at all
    return null;
  }

  List<RouteBase> _configureRoutes() {
    return <RouteBase>[
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SignInScreen()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: SignInScreen()),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage(
            child: Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () async {
                await context.read<AuthController>().signOut();
              },
              child: Text('ssss'),
            ),
          ),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => ResponsiveApp(
        preferDesktop: true,
        builder: (context) => MaterialApp.router(
          title: 'Namka',
          scaffoldMessengerKey: scaffoldMessengerKey,
          // theme: ,
          // darkTheme:  ,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      );
}
