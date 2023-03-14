import 'package:get/get.dart';
import 'package:study_hub/model/repository/auth_repository.dart';
import '../../../common/constants.dart';
import '../../../model/models/resource.dart';
import '../../../model/models/tokens.dart';
import '../../../presentation/auth/iu_webview.dart';

class LoginWithIUUseCase {
  const LoginWithIUUseCase._();

  static Future<Resource<Token>> invoke() async {
    AuthRepository authRepo = Get.find();

    var data = await Get.to(() => UIWebView(
          authorizationUrl: authorizationUri.toString(),
          redirectUrl: redirectUri,
        ));

    var result = await authRepo.loginWithIU(code: data[0]);

    if (result is Success) {
      return Success(successData: result.data!);
    }

    return Fail(errorMessage: "Error");
  }
}
