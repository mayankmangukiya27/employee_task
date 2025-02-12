import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/helper/db_helper.dart';
import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'employee_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  var dbHelper = DatabaseHelper();

  EmployeeListCubit()
      : super(EmployeeListLoaded(oldEmployees: [], currentEmployees: []));

  Future fetchEmployees() async {
    emit(EmployeeListInitial());
    DateTime today = DateTime.now();
    DateFormat format = DateFormat("d MMM yyyy");

    /// Query of select all employees from SQF lite
    List<Map<String, dynamic>> employees = await dbHelper.getEmployees();
    List<Employee> employeeList =
        employees.map((map) => Employee.fromJson(map)).toList();
    List<Employee> oldEmployee = [];
    List<Employee> currentEmployee = [];
    for (int i = 0; i < employeeList.length; i++) {
      /// Logic of Old Employee
      if (employeeList[i].toDate != null &&
          employeeList[i].toDate != "" &&
          (format.parse(employeeList[i].toDate!).isBefore(today))) {
        oldEmployee.add(employeeList[i]);
      } else {
        currentEmployee.add(employeeList[i]);
      }
    }
    emit(EmployeeListLoaded(
        oldEmployees: oldEmployee, currentEmployees: currentEmployee));
    print(employees);
  }

  void deleteEmployee(Employee employee, BuildContext context) {
    /// Delete Employee Query

    dbHelper.deleteEmployee(employee.id!).then((isChanged) async {
      showBottomToast(context,employee);
     await fetchEmployees();
    });
  }

  void showBottomToast(BuildContext context, Employee employee) {
    /// Show Bottom toast after delete employee
    final snackBar = SnackBar(
      content: Text("Employee data has been deleted"),
      action: SnackBarAction(
        textColor: ColorConstants.primary,
        label: "Undo",
        onPressed: () {
          dbHelper.insertEmployee({
            "name": employee.name,
            "role": employee.role,
            "fromDate": employee.toDate,
            "toDate": employee.toDate
          });
          fetchEmployees();
        },
      ),
      behavior: SnackBarBehavior.floating,
      // Makes it float above the bottom
      margin: EdgeInsets.all(16),
      // Adds margin around it
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
