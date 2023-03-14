import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favourites/favourites_page.dart';
import 'my_decks/my_deck_page.dart';
import 'settings/setting_page.dart';
import '../../util/color_codes.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: TabBar(
            controller: controller.tabController,
            labelColor: selectedTabColor,
            unselectedLabelColor: unselectedTabColor,
            indicatorColor: selectedTabColor,
            indicatorSize: TabBarIndicatorSize.label,
            //isScrollable: true,
            tabs: const [
              //Tab(text: 'Groups'),
              Tab(text: "Favourites"),
              Tab(text: "My Decks"),
              //Tab(text: 'History'),
              //Tab(text: 'Notifications'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const <Widget>[
          //GroupsPage(),
          FavouritesPage(),
          MyDecksPage(),
          //HistoryPage(),
          //NotificationsPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
