import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screen/splash_screen.dart';
import 'package:todo_app/screen/task_screen.dart';
import 'package:todo_app/screen/todo_screen.dart';

class AppRoute{
  static String splashScreen = 'splash';
  static String taskScreen = 'task';
  static String todoScreen = 'todo';

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    if(settings.name == splashScreen){
      return splashRoute();
    }
    else if(settings.name == taskScreen){
      return MaterialPageRoute(builder: (BuildContext context) => const TaskScreen());
    }
    else if(settings.name == todoScreen){
      return MaterialPageRoute(builder: (BuildContext context) => const TodoScreen());
    }
    return splashRoute();
  }

  static Route<dynamic> splashRoute(){
    return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
  }
}