import 'package:charity/modules/common/presentation/charity_state.dart';
import 'package:charity/modules/home/domain/entities/home_data.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDataNotifier extends StateNotifier<CharityState<HomeData>> {
  HomeDataNotifier({
    required this.repository,
  }) : super(Success(HomeData.empty()));

  final MenuRepository repository;

  Future<void> loadMenu() async {
    state = Loading();

    try {
      final menu = await repository.getUserMenu();
      state = Success(HomeData.fromMenu(menu));
    } catch (e) {
      state = Error(
        error: e,
        message: 'Erro ao recuperar o menu',
      );
    }
  }
}
