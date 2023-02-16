import 'dart:async';

import 'package:pruebaTest/app/app_settings.dart';
import 'package:pruebaTest/data/models/InfoProductModel.dart';

import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/redux2/app/app_state.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


import 'settingsHomeActions.dart';

class settingHomeMiddleware extends MiddlewareClass<AppState> {
  settingHomeMiddleware(this.api);

  final API api;

  @override
  Future<void> call(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
  
      

      if (action is getProductAction) {
        return _getListProduct(next, action, store);
      }
    }
  }


 Future<void> _getListProduct(
      NextDispatcher next, getProductAction action, Store<AppState> store) async {

    var response = await API().getProduct(search: action.search
    );


    switch (response.statusCode) {
      case AppSettings.statusCodeSuccess:


        ModelInfoProduct data = modelInfoProductFromJson(response.data.toString());
        ReduxHome.store.dispatch(
          SetPostsStateActionHome( PostsStateHome(
             modelInfoProduct: data
          )),
        );



        break;
      case AppSettings.statusCodeError:

        AlertWidget().message(action.context, response.message);



        break;
      default:
        AlertWidget().message(action.context, response.message);
    }
    
  }

  


