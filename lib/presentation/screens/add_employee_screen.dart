import 'package:employee_app/constants/string_const.dart';
import 'package:employee_app/cubit/add_employee_cubit.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:employee_app/widgets/button_widget.dart';
import 'package:employee_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AddEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  AddEmployeeScreen({this.employee});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  void initState() {
    if (widget.employee != null) {
      BlocProvider.of<AddEmployeeCubit>(context).setupInfo(widget.employee!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.addEmployeeDetails),
        actions: [
          widget.employee != null
              ? InkWell(
            onTap: () => BlocProvider.of<AddEmployeeCubit>(context)
                .deleteEmployee(widget.employee!.id!, context),
            child: Icon(
              Icons.delete,
              color: ColorConstants.primary,
            ),
          )
              : SizedBox(),
          SizedBox(width: 20,)
        ],
      ),
      body: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        builder: (context, state) {
          if (state is EmployeeAdded)
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          if (state is AddingEmployee) CircularProgressIndicator();
          return Container(
            margin: EdgeInsets.all(20.0),
            child: _body(context),
          );
        },
        listener: (context, state) {

        },
      ),
      bottomNavigationBar: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
          builder: (context, state) {
            return _bottomView(context);
          },
          listener: (context, state) {}),
    );
  }

  Widget _body(context) {
    final employeeCubit = BlocProvider.of<AddEmployeeCubit>(context);
    return Column(
      children: [
        InputTextField(
          controller: employeeCubit.nameController,
          hintText: StringConst.employeeName,
          prefixIcon: Icon(
            Icons.person,
            color: ColorConstants.primary,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        InputTextField(
          controller: employeeCubit.selectRoleController,
          hintText: StringConst.selectRole,
          readOnly: true,
          onTap: ()=>BlocProvider.of<AddEmployeeCubit>(context)
              .roleBottomSheet(context),
          prefixIcon: Icon(
            Icons.shopping_bag_outlined,
            color: ColorConstants.primary,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 30,
            color: ColorConstants.primary,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
                child: InputTextField(
                  hintText: StringConst.noDate,
                  onTap: () => employeeCubit.fromDatePicker(context),
                  readOnly: true,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: ColorConstants.primary,
                  ),
                  controller: employeeCubit.fromDateController,
                )),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_outlined,
              color: ColorConstants.primary,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: InputTextField(
                  hintText: StringConst.noDate,
                  readOnly: true,
                  onTap: () => employeeCubit.toDatePicker(context),
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: ColorConstants.primary,
                  ),
                  controller: employeeCubit.toDateController,
                )),
          ],
        )
      ],
    );
  }

  Widget _bottomView(context) {
    final employeeCubit = BlocProvider.of<AddEmployeeCubit>(context);
    return SizedBox(
      height: 60,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Color(0xFFF2F2F2),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                width: 80,
                textColor: ColorConstants.primary,
                color: ColorConstants.primary.withValues(alpha: 0.2),
              ),
              SizedBox(
                width: 10,
              ),
              ButtonWidget(
                onTap: () {
                  if (widget.employee != null) {
                    employeeCubit.updateInfo(widget.employee!.id!, context);
                  } else {
                    employeeCubit.addEmployee(context);
                  }
                },
                text: "Save",
                width: 80,
                textColor: Colors.white,
                color: ColorConstants.primary,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
