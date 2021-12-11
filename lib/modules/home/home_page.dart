import 'package:flutter/material.dart';
import 'package:flutter_race_01_ta_caro/modules/create/create_bottomsheet.dart';

import 'package:flutter_race_01_ta_caro/shared/models/user_model.dart';
import 'package:flutter_race_01_ta_caro/shared/theme/app_theme.dart';
import 'package:flutter_race_01_ta_caro/shared/widgets/bottom_navigator/app_bottom_navigator.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  final List<Widget> pages;
  const HomePage({
    Key? key,
    required this.user,
    required this.pages,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  late final List<Widget> pages = widget.pages;

  void changeIndex(int index) async {
    if (index == 3) {
      await showModalBottomSheet(
        context: context,
        builder: (context) => CreateBottomsheet(),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      );
    } else {
      currentIndex = index;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Stack(
            children: [
              Container(
                key: UniqueKey(),
                child: List.from(pages)[currentIndex],
              ),
              Positioned(
                bottom: 14,
                left: 16,
                right: 16,
                child: AppBottomNavigator(
                  currentIndex: currentIndex,
                  onChanged: changeIndex,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
