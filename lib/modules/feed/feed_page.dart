import 'package:flutter/material.dart';
import 'package:flutter_race_01_ta_caro/modules/feed/feed_controller.dart';
import 'package:flutter_race_01_ta_caro/modules/feed/repositories/feed_repository_impl.dart';
import 'package:flutter_race_01_ta_caro/shared/models/order_model.dart';
import 'package:flutter_race_01_ta_caro/shared/services/app_database.dart';
import 'package:flutter_race_01_ta_caro/shared/theme/app_text.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/card_chart/card_chart.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/card_product/card_product.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/list_tile/app_list_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;

  @override
  void initState() {
    controller = FeedController(
        repository: FeedRepositoryImpl(database: AppDatabase.instance));
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 106),
        child: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, __) => controller.state.when(
                orElse: () => Container(),
                success: (value) {
                  final orders = value as List<OrderModel>;
                  final products = controller.products;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardChat(
                              value: controller.sumTotal,
                              percent: controller.calcChart(products),
                            ),
                            SizedBox(height: 27),
                            Text("Preço dos produtos").label,
                            SizedBox(height: 14),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 126,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) => CardProduct(
                              product: products[index],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 27),
                            Text("Suas últimas compras").label,
                            SizedBox(height: 14),
                            for (var order in orders)
                              AppListTile(
                                order: order,
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
