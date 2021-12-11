import 'package:flutter_race_01_ta_caro/modules/login/repositories/login_repository.dart';
import 'package:flutter_race_01_ta_caro/shared/models/user_model.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';

class LoginRepositoryImpl implements LoginRepository {
  final AppDatabase database;

  LoginRepositoryImpl({required this.database});

  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await database.createAccount(
        email: email, password: password, name: name);
    return response;
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await database.login(email: email, password: password);
    return response;
  }
}
