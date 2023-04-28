import 'package:assurance/modules/home/controllers/home_controller.dart';
import 'package:assurance/modules/home/pages/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            body: IndexedStack(
              children: _.tabs,
              index: _.currentIndex,
            ),
            bottomNavigationBar: BottomNavigationWidget(),
          );
        });
  }
}
