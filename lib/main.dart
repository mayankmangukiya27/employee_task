import 'package:flutter/material.dart';

import 'presentation/router.dart';

void main() {
  runApp(EmployeeApp(
    router: AppRouter(),
  ));
}

class EmployeeApp extends StatelessWidget {
  final AppRouter router;
  const EmployeeApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
