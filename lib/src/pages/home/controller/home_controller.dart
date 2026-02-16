import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();
  final _utilServices = UtilsServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];

  void setLoading(bool value) {
    isLoading = value;

    update();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> homeResult =
        await _homeRepository.getAllCategories();

    setLoading(false);
    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);
      },
      error: (message) {
        _utilServices.showToast(msg: message, isError: true);
      },
    );
  }
}
