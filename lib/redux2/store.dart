import 'dart:async';

import 'package:pruebaTest/data/networking/api.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeMiddleware.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';

import 'package:flutter/material.dart';

import 'package:redux/redux.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';

/*Persistor<AppState> createPersistor(String key) => Persistor<AppState>(
    storage: new WebStorage(key),
    serializer: JsonSerializer<AppState>(AppState.rehydrationJSON));*/
@immutable
class AppStateCheckoutSlit {

  final PostsStateHome settingHomeState;

  AppStateCheckoutSlit({
 //  @required this.postsState,
    @required this.settingHomeState,

  });

  AppStateCheckoutSlit copyWith({

    PostsStateHome settingHomeState,

  }) {
    return AppStateCheckoutSlit(
    //  postsState: postsState ?? this.postsState,
        settingHomeState: settingHomeState ?? this.settingHomeState,
    );
  }
}

Future<Store<AppState>> createStore(
    {API api}) async {
  var prefs = await SharedPreferences.getInstance();
  AppState initialState;
  //AppStateHome initialState;


    initialState = AppState.initial();


  Store<AppState> store = Store(appReducer,
      initialState: initialState ?? AppState.initial(),
      distinct: true,
      middleware: [

        settingHomeMiddleware(api)

        //  persistor.createMiddleware(),
      ]);
 // api.loadStore(store);
  return store;
}
