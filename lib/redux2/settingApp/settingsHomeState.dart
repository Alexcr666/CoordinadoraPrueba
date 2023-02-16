
import 'package:pruebaTest/data/models/InfoProductModel.dart';
import 'package:meta/meta.dart';


@immutable
class PostsStateHome {
  final bool isError;
  final bool isLoading;


 final String search;
 final ModelInfoProduct modelInfoProduct;

  // final List<modelFavorites> posts;

  PostsStateHome({

    this.isError,

    this.isLoading,


    this.search,
    this.modelInfoProduct,
    

    //this.posts,
  });

  factory PostsStateHome.initial() => PostsStateHome(
        isLoading: false,
        isError: false,



    search: "Barranquilla",
    modelInfoProduct: null,

      );

  PostsStateHome copyWith({
    @required bool isError,

    @required bool isLoading,


    @required String search,
    @required ModelInfoProduct modelInfoProduct,

  }) {
    return PostsStateHome(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,


      
      search: search ?? this.search,
      modelInfoProduct :  modelInfoProduct ?? this.modelInfoProduct,

    );
  }
}
