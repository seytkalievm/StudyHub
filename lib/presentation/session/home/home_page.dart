import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recent/recent_page.dart';
import '../../util/color_codes.dart';
import 'for_you/for_you_page.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: TabBar(
              controller: controller.tabController,
              labelColor: selectedTabColor,
              unselectedLabelColor: unselectedTabColor,
              indicatorColor: selectedTabColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'For You'),
                Tab(text: 'Recent'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: const <Widget>[
            ForYouPage(),
            RecentPage(),
          ],
        ),
      );
    });
  }
}
