import 'package:charity/modules/common/module/common_providers.dart';
import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/home/domain/entities/home_data.dart';
import 'package:charity/modules/home/presentation/pages/select_category/notifiers/category_menu_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryMenuNotifierProvider =
    StateNotifierProvider<CategoryMenuNotifier, CharityState<HomeData>>((ref) {
  return CategoryMenuNotifier(
    repository: ref.watch(menuRepositoryProvider),
  );
});
