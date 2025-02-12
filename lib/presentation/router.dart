import 'package:employee_app/constants/routes_strings.dart';
import 'package:employee_app/cubit/add_employee_cubit.dart';
import 'package:employee_app/cubit/employee_cubit.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/add_employee_screen.dart';
import 'screens/employee_list_screen.dart';


class AppRouter {

  late EmployeeListCubit employeeListCubit;

  AppRouter() {

    employeeListCubit = EmployeeListCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: employeeListCubit,
              child: EmployeeListScreen(),
            ));

      case ADD_EMPLOYEE_ROUTE:
        Employee? employee = settings.arguments==null?null: settings.arguments as Employee;
        return MaterialPageRoute(

            builder: (_) => BlocProvider(
              create: (context) => AddEmployeeCubit(

                employeeListCubit: employeeListCubit,
              ),
              child: AddEmployeeScreen(employee: employee,),
            ));
      default:
        return null;
    }
  }
}
