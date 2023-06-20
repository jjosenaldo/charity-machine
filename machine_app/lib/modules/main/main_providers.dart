import 'package:charity/modules/home/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final homeDataNotifier = ref.watch(homeDataProvider.notifier);

  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => homeDataNotifier.loadMenu(),
          );

          return const SelectCategoryPage();
        },
      ),
    ],
  );
});
