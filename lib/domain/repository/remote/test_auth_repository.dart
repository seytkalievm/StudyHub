import 'package:study_hub/model/models/resource.dart';
import 'package:study_hub/model/models/tokens.dart';
import 'package:study_hub/model/repository/auth_repository.dart';

class TestAuthRepository implements AuthRepository {
  static const duration = Duration(milliseconds: 20);

  @override
  Future<Resource<Token>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(duration);

    return Success(
      successData: Token(accessToken: "access", refreshToken: "refresh"),
    );
  }

  @override
  Future<Resource<Token>> loginWithIU({required String code}) async {
    await Future.delayed(duration);

    return Success(
      successData: Token(accessToken: "access", refreshToken: "refresh"),
    );
  }

  @override
  Resource<int> logout() {
    return Success(successData: 1);
  }

  @override
  Future<Resource<String>> refresh() async {
    await Future.delayed(duration);

    return Success(successData: "refresh");
  }

  @override
  Future<Resource<Token>> register({
    required String email,
    required String fullName,
    required String password,
  }) async {
    await Future.delayed(duration);

    return Success(
      successData: Token(accessToken: "access", refreshToken: "refresh"),
    );
  }
}
