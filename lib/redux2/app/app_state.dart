
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppState extends Equatable {
  AppState({

    @required this.settingHomeState,
  });


  final PostsStateHome settingHomeState;

  static AppState rehydrationJSON(dynamic json) {
    return json != null
        ? AppState(

    settingHomeState: PostsStateHome(),
    )
        : AppState.initial();
  }

  Map<String, dynamic> toJson() => {
        //       'auth': authState.toJson(),
        //     'checkout': checkoutState.toJson(),
      };

  factory AppState.initial() {
    return AppState(

      settingHomeState: PostsStateHome(),
    );
  }

  AppState copyWith({

    PostsStateHome settingHomeState,
  }) =>
      AppState(

        settingHomeState: settingHomeState ?? this.settingHomeState,
      );

  @override
  List<Object> get props => [

    settingHomeState,
      ];
}
