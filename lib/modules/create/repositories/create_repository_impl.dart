import 'package:flutter_race_01_ta_caro/modules/create/repositories/create_respository.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';

class CreateRepositoryImpl implements ICreateRepository {
  final AppDatabase database;
  final String userId;

  CreateRepositoryImpl({
    required this.database,
    required this.userId,
  });

  @override
  Future<bool> create({
    required String name,
    required String price,
    required String date,
  }) async {
    final priceSanitize = double.parse(price.replaceAll("R\$", ""));
    final dateFormatted = date.split("/").reversed.join("-");
    final response = await database.create(table: "orders", data: {
      "name": name,
      "price": priceSanitize,
      "created": dateFormatted,
      "user": userId,
    });
    return response;
  }
}
