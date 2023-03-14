import 'package:flutter/foundation.dart';
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
          elevation: kIsWeb ? 0.0 : null,
          backgroundColor: kIsWeb ? backgroundDarkBlue : mainAppColor,
          flexibleSpace: SafeArea(
            child: Container(
              margin: kIsWeb ? const EdgeInsets.only(left: 105) : null,
              child: TabBar(
                isScrollable: kIsWeb ? true : false,
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
