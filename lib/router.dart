import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tokyo_flutter_hack_demo/features/map/map_page.dart';
import 'package:tokyo_flutter_hack_demo/main.dart';
import 'package:tokyo_flutter_hack_demo/pages/register_page.dart';
import 'package:tokyo_flutter_hack_demo/pages/welcome_page.dart';

final goRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomePage())),
  GoRoute(
      path: '/home',
      pageBuilder: (context, state) => const MaterialPage(child: MapPage())),
  GoRoute(
    path: '/welcome',
    pageBuilder: (context, state) => const MaterialPage(child: WelcomePage()),
  ),
  GoRoute(
    path: '/register',
    pageBuilder: (context, state) => const MaterialPage(child: RegisterPage()),
  )
]);
