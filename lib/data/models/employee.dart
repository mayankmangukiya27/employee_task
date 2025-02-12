

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  final int? id;
  final String? role;
  final String? name;
  final String? fromDate;
  final String? toDate;

  Employee({
    this.id,
    this.role,
    this.name,
    this.fromDate,
    this.toDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    role: json["role"],
    name: json["name"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "name": name,
    "fromData": fromDate,
    "toDate": toDate,
  };
}
