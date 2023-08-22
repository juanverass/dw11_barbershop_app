import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbersho/src/core/fp/either.dart';
import 'package:dw_barbersho/src/core/providers/application_providers.dart';
import 'package:dw_barbersho/src/features/adm/home_adm_state.dart';
import 'package:dw_barbersho/src/model/barbershop_model.dart';
import 'package:dw_barbersho/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.read(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) = await ref.read(getMyBarbershopProvider.future);
    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(barbershopId);

    switch (employeesResult) {
      case Success(value: var employeesData):
        final employees = <UserModel>[];
        employees.addAll(employeesData);
        if (me case UserModelADM(workDays: _?, workHours: _?)) {
          employees.add(me);
        }

        return HomeAdmState(status: HomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employees: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}


/// Rodar o comando abaixo
/// dart run build_runner watch -d
/// part 'home_adm_vm.g.dart';