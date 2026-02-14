import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_errors.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {"email": email, "password": password},
    );

    if (response['result'] != null) {
      final user = UserModel.fromJson(response['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrorsString(response['error']));
    }
  }
}
