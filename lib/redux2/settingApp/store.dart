
import 'package:pruebaTest/redux2/settingApp/settingsHomeActions.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeReducer.dart';
import 'package:pruebaTest/redux2/settingApp/settingsHomeState.dart';
import 'package:meta/meta.dart';

import 'package:redux/redux.dart';

AppStateHome appReducerHome(AppStateHome state, dynamic action) {
  if (action is SetPostsStateActionHome) {
    final nextPostsState = postsReducerHome(state.postsState, action);

    return state.copyWith(postsState: nextPostsState);
  }

  return state;
}

@immutable
class AppStateHome {
  final PostsStateHome postsState;

  AppStateHome({
    @required this.postsState,
  });

  AppStateHome copyWith({
    PostsStateHome postsState,
  }) {
    return AppStateHome(
      postsState: postsState ?? this.postsState,
    );
  }
}

class ReduxHome {
  static Store<AppStateHome> _store;

  static Store<AppStateHome> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    final postsStateInitial = PostsStateHome.initial();

    _store = Store<AppStateHome>(
      appReducerHome,
      middleware: [],
      initialState: AppStateHome(postsState: postsStateInitial),
    );
  }
}
