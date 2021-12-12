import 'package:flutter_race_01_ta_caro/modules/create/repositories/create_respository.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';

class CreateRepositoryImpl implements ICreateRepository {
  final AppDatabase database;

  CreateRepositoryImpl({
    required this.database,
  });

  @override
  Future<bool> create({
    required String name,
    required String price,
    required String date,
    required String userId,
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
