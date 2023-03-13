import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/session/home/recent/recent_page.dart';
import 'package:study_hub/session/home/search/search_page.dart';
import '../../util/color_codes.dart';
import 'for_you/for_you_page.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: selectedTabColor,
          unselectedLabelColor: unselectedTabColor,
          indicatorColor: selectedTabColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Recent'),
            Tab(text: 'For You'),
            Tab(text: 'Search'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const <Widget>[
          RecentPage(),
          ForYouPage(),
          SearchPage(),
        ],
      ),
    );
  }
}
