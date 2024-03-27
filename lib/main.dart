import 'package:flutter/material.dart';
import 'package:todo_app/screen/route.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      initialRoute:  AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
    )
  );
}

