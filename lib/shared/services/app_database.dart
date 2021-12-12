import 'package:flutter_race_01_ta_caro/shared/models/user_model.dart';
import 'package:flutter_race_01_ta_caro/shared/services/supabase_database.dart';

abstract class AppDatabase {
  static final AppDatabase instance = SupabaseDatabase();
  void init();
  Future<List<Map<String, dynamic>>> getOrdersByUserId(String userId);
  Future<bool> create({
    required String table,
    required Map<String, dynamic> data,
  });
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String name,
  });
}
