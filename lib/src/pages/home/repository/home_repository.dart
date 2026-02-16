import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (response['result'] != null) {
      List<CategoryModel> data =
          List<Map<String, dynamic>>.from(
            response['result'],
          ).map(CategoryModel.fromJson).toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar as categorias',
      );
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
    Map<String, dynamic> body,
  ) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (response['result'] != null) {
      List<ItemModel> data =
          List<Map<String, dynamic>>.from(
            response['result'],
          ).map(ItemModel.fromJson).toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar os itens',
      );
    }
  }
}
