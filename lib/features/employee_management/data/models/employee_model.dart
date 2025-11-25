// import '../../domain/entities/employee.dart';

// class EmployeeModel extends Employee {
//   EmployeeModel({
//     required String name,
//     required String phone,
//     required String email,
//     required String role,
//     required DateTime createdAt,
//   }) : super(
//          name: name,
//          phone: phone,
//          email: email,
//          role: role,
//          createdAt: createdAt,
//        );

//   factory EmployeeModel.fromMap(Map<String, dynamic> map) {
//     return EmployeeModel(
//       name: map['name'],
//       phone: map['phone'],
//       email: map['email'],
//       role: map['role'],
//       createdAt: DateTime.parse(map['createdAt']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'phone': phone,
//       'email': email,
//       'role': role,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }
