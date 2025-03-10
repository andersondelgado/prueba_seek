import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seek_prueba/feature/QR/bloc/qr_bloc.dart';
import 'package:seek_prueba/feature/QR/ui/qr_ui.dart';
import 'package:seek_prueba/feature/biometric/bloc/biometric_bloc.dart';
import 'package:seek_prueba/feature/biometric/ui/biometric_ui.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: BiometricUi.routeName,
  routes: <RouteBase>[
    GoRoute(
      path: BiometricUi.routeName,
      name: BiometricUi.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const BiometricUi();
      },
    ),
    GoRoute(
      path: QrUi.routeName,
      name: QrUi.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const QrUi();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BiometricBloc(),
        ),
        BlocProvider(
          create: (context) => QrBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
