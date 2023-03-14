import 'package:study_hub/model/models/tokens.dart';
import '../models/resource.dart';

abstract class AuthRepository {
  Future<Resource<Token>> register({
    required String email,
    required String fullName,
    required String password,
  });

  Future<Resource<Token>> login({
    required String email,
    required String password,
  });

  Resource<int> logout();

  Future<Resource<String>> refresh();

  Future<Resource<Token>> loginWithIU({required String code});
}
