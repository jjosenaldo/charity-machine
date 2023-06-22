import 'package:charity/modules/auth/presentation/pages/auth_page.dart';
import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category/select_category_page.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:charity/modules/menu/presentation/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth',
    routes: <RouteBase>[
      StatefulShellRoute(
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              name: '/auth',
              path: '/auth',
              builder: (BuildContext context, GoRouterState state) {
                return const AuthPage();
              },
            ),
            GoRoute(
              name: '/category',
              path: '/category',
              builder: (BuildContext context, GoRouterState state) {
                _runAfterBuild(
                  ref.watch(categoryMenuNotifierProvider.notifier).loadMenu,
                );

                return const SelectCategoryPage();
              },
            ),
            GoRoute(
              name: '/item',
              path: '/item',
              builder: (BuildContext context, GoRouterState state) {
                final items = (state.extra is List<Item>
                        ? state.extra as List<Item>
                        : <Item>[])
                    .where((item) => item.isAvailable)
                    .toList();

                _runAfterBuild(
                  () => ref
                      .read(categoryItemsNotifierProvider.notifier)
                      .setItems(items),
                );

                return const MenuPage();
              },
            ),
          ]),
        ],
        navigatorContainerBuilder: (_, __, children) => children.first,
        builder: (_, __, child) => child,
      ),
    ],
  );
});

void _runAfterBuild(Function function) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => function(),
  );
}
