import 'package:http/http.dart';
import 'package:pruebaTest/data/models/GeSendModel.dart';
import 'package:pruebaTest/data/models/GetNySModel.dart';
import 'package:pruebaTest/data/models/InfoProductModel.dart';
import 'package:meta/meta.dart';

@immutable
class PostsStateHome {
  final bool isError;
  final bool isLoading;

  final String search;
  final ModelInfoProduct modelInfoProduct;
  final GetSendModel getSendModel;
  final GetNysModel getNysModel;
  final List<Guia> listSend;

  // final List<modelFavorites> posts;

  PostsStateHome({
    this.isError,
    this.isLoading,
    this.getSendModel,
    this.search,
    this.modelInfoProduct,
    this.getNysModel,
    this.listSend,

    //this.posts,
  });

  factory PostsStateHome.initial() => PostsStateHome(
      isLoading: false,
      isError: false,
      getSendModel: null,
      search: "Barranquilla",
      modelInfoProduct: null,
      getNysModel: null,
      listSend: null);

  PostsStateHome copyWith({
    @required bool isError,
    @required bool isLoading,
    @required GetSendModel getSendModel,
    @required String search,
    @required ModelInfoProduct modelInfoProduct,
    @required GetNysModel getNysModel,
    @required List<Guia> listSend,
  }) {
    return PostsStateHome(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      getSendModel: getSendModel ?? this.getSendModel,
      search: search ?? this.search,
      modelInfoProduct: modelInfoProduct ?? this.modelInfoProduct,
      getNysModel: getNysModel ?? this.getNysModel,
      listSend: listSend ?? this.listSend,
    );
  }
}
