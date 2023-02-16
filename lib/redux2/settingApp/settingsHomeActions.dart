
import 'package:pruebaTest/redux2/common_actions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';



class getListUserAction extends ErrorAction {
  getListUserAction(BuildContext context) : super(context);

}

class getProductAction extends ErrorAction {
  getProductAction(BuildContext context,this.search) : super(context);
  String search;

}

@immutable
class SetPostsStateActionHome {
  final PostsStateHome postsState;

  SetPostsStateActionHome(this.postsState);
}
