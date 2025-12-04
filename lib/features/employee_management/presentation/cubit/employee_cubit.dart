import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palace_systeam_managment/core/entites/user_entity.dart';

import '../../domain/repositories/employee_repo.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(this.employeeRepo) : super(EmployeeInitial());
  final EmployeeRepo employeeRepo;
  List<UserEntity> employees = [];
  String? selectedSortType = 'الاحدث اولآ';

  void serchEmployee(String query) {
    final filteredEmployee =
        employees.where((user) {
          final nameLower = user.name.toLowerCase();
          final searchLower = query.toLowerCase();
          return nameLower.contains(searchLower);
        }).toList();
    emit(EmployeeLoaded(employees: filteredEmployee));
    if (query.isEmpty) {
      emit(EmployeeLoaded(employees: employees));
    }
  }

  Future<void> fetchEmployees() async {
    emit(EmployeeLoading());
    final result = await employeeRepo.fetchEmployees();
    result.fold((failure) => emit(EmployeeError(failure.errMessage)), (
      employees,
    ) {
      this.employees = employees;
      emit(EmployeeLoaded(employees: employees));
    });
  }

  Future<void> deleteEmployee(UserEntity user) async {
    emit(EmployeeLoading());
    final result = await employeeRepo.deleteEmployee(user);
    result.fold((failure) => emit(EmployeeError(failure.errMessage)), (_) {
      employees.removeWhere((element) => element.email == user.email);
      emit(EmployeeSuccess());
    });
  }

  void sortCustmers(String sortType) {
    if (sortType == "الاحدث اولآ") {
      employees.sort((a, b) => b.name.compareTo(a.name));
    } else if (sortType == "الاقدم اولآ") {
      employees.sort((a, b) => a.name.compareTo(b.name));
    }
    emit(EmployeeLoaded(employees: List.from(employees)));
  }
}
