import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/helper/db_helper.dart';
import 'package:employee_app/widgets/custom_cate_picker.dart';
import 'package:employee_app/widgets/role_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'employee_cubit.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  final EmployeeListCubit employeeListCubit;
  final List roleList = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];
  final nameController = TextEditingController();
  final selectRoleController = TextEditingController();
  final toDateController = TextEditingController();
  final fromDateController = TextEditingController();
  var dbHelper = DatabaseHelper();

  AddEmployeeCubit({required this.employeeListCubit})
      : super(AddEmployeeInitial());

  addEmployee(BuildContext context) async {
    FocusScope.of(context).unfocus();
    /// Adding Employee to the SQF lite
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter Employee name")));
    } else if (selectRoleController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select role")));
    } else if (fromDateController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please pick from date")));
    } else {

      emit(AddingEmployee());
      await dbHelper.insertEmployee({
        "name": nameController.text,
        "role": selectRoleController.text,
        "fromDate": fromDateController.text,
        "toDate": toDateController.text
      });
      emit(EmployeeAdded());
    }
  }

  roleBottomSheet(BuildContext context) {
    /// Role Option which is open from bottom sheet
    return showModalBottomSheet(
        context: context,
        builder: (context) => RoleBottomSheet(
              roleList: roleList,
              onTap: (value) {
                Navigator.pop(context);
                selectRoleController.text = value;
              },
            ));
  }

  fromDatePicker(BuildContext context) async {
    commonDatePicker(
        context: context,
        onSave: (date) {
          if (date != null) {
            fromDateController.text = formatDate(date);
            Navigator.pop(context);
          }
        },
        isFrom: true);
  }

  toDatePicker(BuildContext context) async {
    commonDatePicker(
        context: context,
        isFrom: false,
        onSave: (date) {
          if (date != null) {
            toDateController.text = formatDate(date);
          }
          Navigator.pop(context);
        });
  }

  commonDatePicker(
      {required BuildContext context,
      required Function(DateTime?) onSave,
      required bool isFrom}) {
    /// Common Date Picker
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 580,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomDatePicker(
                  isFromDate: isFrom,
                  onSave: (date) => onSave(date!),
                ),
              ),
            ),
          );
        });
  }

  setupInfo(Employee employee) {
    /// This function will call if employee is click on employee list
    nameController.text = employee.name!;
    selectRoleController.text = employee.role!;
    fromDateController.text = employee.fromDate!;
    toDateController.text = employee.toDate ?? "";

    emit(EmployeeSetup());
  }

  updateInfo(int id, BuildContext context) async {
    /// Database query of update employee
    if (nameController.text.isEmpty) {
         ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Please enter Employee name")));
      } else if (selectRoleController.text.isEmpty) {
          ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(content: Text("Please select role")));
         } else if (fromDateController.text.isEmpty) {
         ScaffoldMessenger.of(context)
               .showSnackBar(SnackBar(content: Text("Please pick from date")));
         } else {
      int value = await dbHelper.updateEmployee(id, {
        "name": nameController.text,
        'role': selectRoleController.text,
        'fromDate': fromDateController.text,
        'toDate': toDateController.text
      });
      emit(EmployeeSetup());
      Navigator.pop(context);
    }

  }

  deleteEmployee(int id, BuildContext context) async {
    /// Delete query of delete employee
    int value = await dbHelper.deleteEmployee(id);
    Navigator.pop(context);
  }
}
