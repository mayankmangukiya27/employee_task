part of 'employee_cubit.dart';

@immutable
abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<Employee>? oldEmployees;
  final List<Employee>? currentEmployees;
  EmployeeListLoaded({required this.oldEmployees,required this.currentEmployees});
}

