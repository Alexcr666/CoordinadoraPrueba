import 'package:pruebaTest/ui/login/login_screen.dart';
import 'package:pruebaTest/ui/main/infoProductScreen.dart';
import 'package:pruebaTest/ui/main/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:pruebaTest/ui/main/mapsScreen.dart';

final mainRoutes = {
  'login': (BuildContext context) => LoginScreen(),
  'main': (BuildContext context) => usersListPage(),
  'result': (BuildContext context) => infoProductPage(),
  'maps': (BuildContext context) => mapResumePage(),
  //'profile': (BuildContext context) => usersListProfilePage(),
};
