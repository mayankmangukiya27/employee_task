import 'package:employee_app/shared/constants/color_constants.dart';
import 'package:employee_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/string_const.dart';

/// Date picker customize
class CustomDatePicker extends StatefulWidget {
  final Function(DateTime?) onSave;
  final bool isFromDate;

  const CustomDatePicker(
      {super.key, required this.onSave, required this.isFromDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String selected="";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.isFromDate
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ButtonWidget(
                        onTap: () {
                          _selectedDay = DateTime.now();
                          selected = StringConst.today;
                          setState(() {});
                        },
                        text: StringConst.today,
                        color:selected==StringConst.today?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                        textColor:selected==StringConst.today?Colors.white: ColorConstants.primary,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ButtonWidget(
                              onTap: () {
                                _selectedDay = getNextMonday();
                                selected = StringConst.nextMonday;
                                setState(() {});
                              },
                              text: StringConst.nextMonday,
                            color:selected==StringConst.nextMonday?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                            textColor:selected==StringConst.nextMonday?Colors.white: ColorConstants.primary,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ButtonWidget(
                        onTap: () {
                          _selectedDay = getNextTuesday();
                          selected = StringConst.nextTuesday;
                          setState(() {});
                        },
                        text: StringConst.nextTuesday,
                            color:selected==StringConst.nextTuesday?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                            textColor:selected==StringConst.nextTuesday?Colors.white: ColorConstants.primary,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ButtonWidget(
                        onTap: () {
                          DateTime today = DateTime.now();
                          _selectedDay = today.add(Duration(days: 7));
                          selected = StringConst.afterOneWeek;
                          setState(() {});
                        },
                        text: StringConst.afterOneWeek,
                            color:selected==StringConst.afterOneWeek?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                            textColor:selected==StringConst.afterOneWeek?Colors.white: ColorConstants.primary,
                      )),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ButtonWidget(
                        onTap: () {
                          _selectedDay = null;
                          selected = StringConst.noDate;
                          setState(() {});
                        },
                        text: StringConst.noDate,
                            color:selected==StringConst.noDate?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                            textColor:selected==StringConst.noDate?Colors.white: ColorConstants.primary,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ButtonWidget(
                              color:selected==StringConst.today?ColorConstants.primary: ColorConstants.primary.withValues(alpha: 0.1),
                              textColor:selected==StringConst.today?Colors.white: ColorConstants.primary,
                              onTap: () {
                                _selectedDay = DateTime.now();
                                selected = StringConst.today;
                                setState(() {});
                              },
                              text: StringConst.today)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
        TableCalendar(
          headerStyle: HeaderStyle(
              titleTextStyle: GoogleFonts.poppins(),
              titleCentered: true,
              rightChevronIcon: Icon(Icons.arrow_right),
              leftChevronIcon: Icon(Icons.arrow_left)),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          calendarStyle: CalendarStyle(
              weekendTextStyle: GoogleFonts.poppins(color: Colors.black),
              rangeEndTextStyle: GoogleFonts.poppins(color: Colors.black),
              rangeStartTextStyle: GoogleFonts.poppins(color: Colors.black),
              withinRangeTextStyle: GoogleFonts.poppins(color: Colors.black),
              selectedTextStyle: GoogleFonts.poppins(color: Colors.white),
              disabledTextStyle: GoogleFonts.poppins(color: Colors.black),
              selectedDecoration: BoxDecoration(
                  color: ColorConstants.primary,
                  shape: BoxShape.circle,
                  border: Border(
                      top: BorderSide(color: ColorConstants.primary),
                      bottom: BorderSide(color: ColorConstants.primary),
                      left: BorderSide(color: ColorConstants.primary),
                      right: BorderSide(color: ColorConstants.primary))),
              todayTextStyle: GoogleFonts.poppins(color: Colors.black),
              todayDecoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border(
                      top: BorderSide(color: ColorConstants.primary),
                      bottom: BorderSide(color: ColorConstants.primary),
                      left: BorderSide(color: ColorConstants.primary),
                      right: BorderSide(color: ColorConstants.primary)))),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              // Keep the focus on the previous month if selectedDay is outside the focused month
              _focusedDay = focusedDay;
              selected = "";
            });
          },
          availableCalendarFormats: {
            CalendarFormat.month: 'Month',
          },
        ),
        Container(
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDay != null ? formatDate(_selectedDay!) : "",
              style: GoogleFonts.poppins(),
            ),
            Row(
              children: [
                ButtonWidget(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: StringConst.cancel,
                  width: 80,
                  color: ColorConstants.primary.withValues(alpha: 0.3),
                  textColor: ColorConstants.primary,
                ),
                SizedBox(
                  width: 10,
                ),
                ButtonWidget(
                  onTap: () => widget.onSave(_selectedDay??null),
                  text: StringConst.save,
                  width: 80,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  DateTime getNextMonday() {
    /// Logic of calculate next monday from date of today
    DateTime today = DateTime.now();
    int daysUntilNextMonday = (8 - today.weekday) % 7;
    if (daysUntilNextMonday == 0) {
      daysUntilNextMonday = 7;
    }
    return today.add(Duration(days: daysUntilNextMonday));
  }

  DateTime getNextTuesday() {
    /// Logic of calculate next thursday from date of today
    DateTime today = DateTime.now();
    int daysUntilNextTuesday = (9 - today.weekday) % 7;
    if (daysUntilNextTuesday == 0) {
      daysUntilNextTuesday = 7;
    }
    return today.add(Duration(days: daysUntilNextTuesday));
  }
}

String formatDate(DateTime date) {
  /// Date Format code
  return DateFormat("d MMM yyyy").format(date);
}
