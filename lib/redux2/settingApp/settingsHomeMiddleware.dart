import 'dart:async';
import 'dart:convert';

import 'package:pruebaTest/app/app_settings.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:pruebaTest/data/models/GetNySModel.dart';
import 'package:pruebaTest/data/models/InfoProductModel.dart';

import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/redux2/app/app_state.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:pruebaTest/redux2/settingApp/store.dart';
import 'package:pruebaTest/sharedPreferences/shared.dart';
import 'package:pruebaTest/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:pruebaTest/utils/utils.dart';
import 'package:redux/redux.dart';

import 'settingsHomeActions.dart';

class settingHomeMiddleware extends MiddlewareClass<AppState> {
  settingHomeMiddleware(this.api);

  final API api;

  @override
  Future<void> call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is getSendAction) {
      return _getSend(next, action, store);
    }

    if (action is getNySAction) {
      return _getNys(next, action, store);
    }
    if (action is getSendNySAction) {
      return _SendNys(next, action, store);
    }
  }
}

Future<void> _getSend(NextDispatcher next, getSendAction action, Store<AppState> store) async {
  AlertWidget().message(action.context, "Buscando...");
  Utils().functionCheckInternet(action.context).then((value) async {
    if (value == true) {
      ReduxHome.store.dispatch(
        SetPostsStateActionHome(
            PostsStateHome(listSend: ReduxHome.store.state.postsState.getSendModel.clientes[action.search.toString()].guias)),
      );
    } else {
      var response = await API().getSend();

      switch (response.statusCode) {
        case AppSettings.statusCodeSuccess:
          GetSendModel data = getSendModelFromJson(response.data.toString());
          ReduxHome.store.dispatch(
            SetPostsStateActionHome(PostsStateHome(getSendModel: data)),
          );
          AppSharedPreference().saveSend(action.context, data);

          ReduxHome.store.dispatch(
            SetPostsStateActionHome(PostsStateHome(listSend: data.clientes[action.search.toString()].guias)),
          );

          break;
        case AppSettings.statusCodeError:
          AlertWidget().message(action.context, response.message);

          break;
        default:
          AlertWidget().message(action.context, response.message);
      }
    }
  });
}

Future<void> _getNys(NextDispatcher next, getNySAction action, Store<AppState> store) async {
  var response = await API().getSend();

  switch (response.statusCode) {
    case AppSettings.statusCodeSuccess:
      GetNysModel data = getNysModelFromJson(response.data.toString());
      ReduxHome.store.dispatch(
        SetPostsStateActionHome(PostsStateHome(getNysModel: data)),
      );

      break;
    case AppSettings.statusCodeError:
      AlertWidget().message(action.context, response.message);

      break;
    default:
      AlertWidget().message(action.context, response.message);
  }
}

Future<void> _SendNys(NextDispatcher next, getSendNySAction action, Store<AppState> store) async {
  var response = await API()
      .sendNyS(action.context, action.message, action.dateReport, action.dateExecute, action.messageSolutions, action.guia, action.cliente);

  switch (response.statusCode) {
    case AppSettings.statusCodeSuccess:
      break;
    case AppSettings.statusCodeError:
      AlertWidget().message(action.context, response.message);

      break;
    default:
      AlertWidget().message(action.context, response.message);
  }
}
