import 'package:charity/modules/machine/data/service/impl/http_machine_service.dart';
import 'package:charity/modules/machine/data/service/machine_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final machineServiceProvider = Provider<MachineService>((ref) {
  return HttpMachineService();
});
