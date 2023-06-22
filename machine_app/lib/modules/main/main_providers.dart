import 'package:charity/modules/home/domain/entities/item.dart';
import 'package:charity/modules/home/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category_page.dart';
import 'package:charity/modules/menu/presentation/pages/menu_page.dart';
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
      GoRoute(
        path: '/menu',
        name: '/menu',
        builder: (BuildContext context, GoRouterState state) {
          final items =
              state.extra is List<Item> ? state.extra as List<Item> : <Item>[];

          return MenuPage(items: items);
        },
      ),
    ],
  );
});
