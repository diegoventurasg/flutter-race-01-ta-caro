import 'package:flutter_race_01_ta_caro/modules/feed/repositories/feed_repository.dart';
import 'package:flutter_race_01_ta_caro/shared/models/order_model.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';

class FeedRepositoryImpl implements IFeedRepository {
  final AppDatabase database;
  FeedRepositoryImpl({
    required this.database,
  });

  @override
  Future<List<OrderModel>> getOrdersByUserId(String userId) async {
    final response = await database.getOrdersByUserId(userId);
    return response.map((e) => OrderModel.fromMap(e)).toList();
  }
}
