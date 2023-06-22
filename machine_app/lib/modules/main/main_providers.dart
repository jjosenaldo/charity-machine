import 'package:charity/modules/common/domain/entities/item.dart';
import 'package:charity/modules/home/home_providers.dart';
import 'package:charity/modules/home/presentation/pages/select_category/select_category_page.dart';
import 'package:charity/modules/menu/menu_providers.dart';
import 'package:charity/modules/menu/presentation/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final homeDataNotifier = ref.watch(categoryMenuNotifierProvider.notifier);

  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/category',
        builder: (BuildContext context, GoRouterState state) {
          _runAfterBuild(homeDataNotifier.loadMenu);

          return const SelectCategoryPage();
        },
      ),
      GoRoute(
        path: '/item',
        name: '/item',
        builder: (BuildContext context, GoRouterState state) {
          final items =
              (state.extra is List<Item> ? state.extra as List<Item> : <Item>[])
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
    ],
  );
});

void _runAfterBuild(Function function) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) => function(),
  );
}
