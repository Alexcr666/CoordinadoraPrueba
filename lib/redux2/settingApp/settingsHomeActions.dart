import 'package:pruebaTest/redux2/common_actions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

class getListUserAction extends ErrorAction {
  getListUserAction(BuildContext context) : super(context);
}

class getProductAction extends ErrorAction {
  getProductAction(BuildContext context, this.search) : super(context);
  String search;
}

class getSendAction extends ErrorAction {
  getSendAction(BuildContext context, this.search) : super(context);
  String search;
}

class getSendNySAction extends ErrorAction {
  getSendNySAction(BuildContext context, {this.message, this.dateReport, this.dateExecute, this.messageSolutions, this.guia, this.cliente})
      : super(context);
  String message;
  String dateReport;
  String dateExecute;
  String messageSolutions;
  String guia;
  String cliente;
}

class getNySAction extends ErrorAction {
  getNySAction(BuildContext context) : super(context);
}

@immutable
class SetPostsStateActionHome {
  final PostsStateHome postsState;

  SetPostsStateActionHome(this.postsState);
}
