import 'package:employee_app/constants/routes_strings.dart';
import 'package:employee_app/constants/string_const.dart';
import 'package:employee_app/cubit/employee_cubit.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:employee_app/widgets/no_record_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    BlocProvider.of<EmployeeListCubit>(context).fetchEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(StringConst.employeeList),
      ),
      body: BlocConsumer<EmployeeListCubit, EmployeeListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (!(state is EmployeeListLoaded))
            return Center(child: CircularProgressIndicator());
          final oldEmployee = (state).oldEmployees;
          final currentEmployee = (state).currentEmployees;
          if (oldEmployee!.isEmpty && currentEmployee!.isEmpty) {
            return NoEmployFoundComponent();
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Current Employee view
                Visibility(
                    visible: currentEmployee!.isNotEmpty,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          color: Colors.grey.withValues(alpha: 0.5),
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                StringConst.currentEmployee,
                                style: GoogleFonts.poppins(
                                    color: ColorConstants.primary),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: currentEmployee.length,
                            itemBuilder: (BuildContext context, int index) {
                              return employeeWidget(
                                  currentEmployee[index], context, false);
                            })
                      ],
                    )),

                /// old employee view
                Visibility(
                  visible: oldEmployee.isNotEmpty,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        color: Colors.grey.withValues(alpha: 0.5),
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              StringConst.previousEmployee,
                              style: GoogleFonts.poppins(
                                  color: ColorConstants.primary),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: oldEmployee.length,
                          itemBuilder: (BuildContext context, int index) {
                            return employeeWidget(
                                oldEmployee[index], context, true);
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(StringConst.swipeLeftToDelete),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, ADD_EMPLOYEE_ROUTE).then((value) {
          BlocProvider.of<EmployeeListCubit>(context).fetchEmployees();
        }),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ColorConstants.primary),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget employeeWidget(Employee? employee, context, bool isToShow) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, ADD_EMPLOYEE_ROUTE, arguments: employee)
              .then((value) =>
                  BlocProvider.of<EmployeeListCubit>(context).fetchEmployees()),
      child: Slidable(
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(onPressed: (context){
            BlocProvider.of<EmployeeListCubit>(context)
                .deleteEmployee(employee!, context);
          },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]),
          child: _employeeView(employee, context,
              isToShow))
      ,
    );
  }

  Widget _employeeView(Employee? employee, context, bool isShowTo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee!.name!,
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            employee.role!,
            style: GoogleFonts.poppins(),
          ),
          Row(
            children: [
              Text(
                "From " + employee.fromDate!,
                style: GoogleFonts.poppins(),
              ),
              Text(
                isShowTo ? (" - " + employee.toDate!) : "",
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
