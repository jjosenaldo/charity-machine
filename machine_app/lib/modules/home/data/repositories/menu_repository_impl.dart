import 'package:charity/modules/machine/data/service/machine_service.dart';
import 'package:charity/modules/home/data/datasources/menu_remote_datasource.dart';
import 'package:charity/modules/home/domain/entities/menu.dart';
import 'package:charity/modules/home/domain/repositories/menu_repository.dart';

// TODO: add offline logic (cache / log file)
class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({
    required this.remoteDatasource,
    required this.machineService,
  });

  final MenuRemoteDatasource remoteDatasource;
  final MachineService machineService;

  @override
  Future<Menu> getUserMenu() {
    return remoteDatasource.getUserMenu();
  }

  @override
  Future<void> pickItem(String itemId) {
    return remoteDatasource.pickItem(itemId);
  }
}
