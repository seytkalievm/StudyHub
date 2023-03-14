import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/color_codes.dart';
import 'create/create_deck_page.dart';
import 'home/home_page.dart';
import 'home/search/search_page.dart';
import 'profile/profile_page.dart';
import 'session_controller.dart';

class Session extends StatelessWidget {
  const Session({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<SessionController>(builder: (controller) {
      return kIsWeb
          ? _web(controller, screenSize)
          : Scaffold(
              appBar: _appBar(controller),
              body: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: const [
                    HomePage(),
                    CreateDeckPage(),
                    ProfilePage(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 36, 47, 61),
                onTap: controller.changePage,
                currentIndex: controller.tabIndex,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: [
                  _homePageItem(controller.tabIndex),
                  _createPageItem(controller.tabIndex),
                  _profilePageItem(controller.tabIndex),
                ],
              ),
            );
    });
  }

  _homePageItem(int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/bottom_bar/home_bottom_bar_ic.svg",
        color: index == 0 ? selectedMenuColor : unselectedMenuColor,
      ),
      label: "Home",
    );
  }

  _createPageItem(int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/bottom_bar/create_bottom_bar_ic.svg",
        color: index == 1 ? selectedMenuColor : unselectedMenuColor,
      ),
      label: "Create",
    );
  }

  _profilePageItem(int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/bottom_bar/profile_bottom_bar_ic_no_notification.svg",
        color: index == 2 ? selectedMenuColor : unselectedMenuColor,
      ),
      label: "Profile",
    );
  }

  Scaffold _web(SessionController controller, Size screenSize) {
    return Scaffold(
      appBar: _webAppBar(controller, screenSize),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: controller.tabIndex,
                children: const [
                  HomePage(),
                  CreateDeckPage(),
                  ProfilePage(),
                ],
              ),
            ),
            Container(
              width: screenSize.width,
              color: mainAppColor,
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _webCopyrightText(),
                  _webFooterButtons(controller),
                  _webBackToTop(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _webCopyrightText() {
    return Container(
      width: 270,
      margin: const EdgeInsets.only(top: 25.0, left: 80.0),
      child: Column(
        children: const <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Study Hub",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: "ArchitectsDaughter",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 19,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Copyright © 2022 Innopolis University",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "All Rights Reserved",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _webFooterButtons(SessionController controller) {
    final List<bool> selectedBottomButtons = <bool>[false, false, false];

    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        controller.changePage(index);
      },
      isSelected: selectedBottomButtons,
      renderBorder: false,
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      children: const [
        Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          'Create',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  _webBackToTop() {
    return Container(
      margin: const EdgeInsets.only(top: 35.0, right: 105.0),
      child: TextButton(
        onPressed: () {
          // TODO
        },
        child: const Text(
          "Back to top",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  _webHomePageItem(SessionController controller) {
    return BottomNavigationBarItem(
      icon: Text(
        'Home',
        style: TextStyle(
          color:
              controller.tabIndex == 0 ? selectedMenuColor : unselectedTabColor,
          fontSize: 20,
          fontFamily: 'Roboto',
        ),
      ),
      label: "",
    );
  }

  _webCreatePageItem(SessionController controller) {
    return BottomNavigationBarItem(
      icon: Text(
        'Create',
        style: TextStyle(
          color:
              controller.tabIndex == 1 ? selectedMenuColor : unselectedTabColor,
          fontSize: 20,
          fontFamily: 'Roboto',
        ),
      ),
      label: "",
    );
  }

  _webProfilePageItem(SessionController controller) {
    return BottomNavigationBarItem(
      icon: Text(
        'Profile',
        style: TextStyle(
          color:
              controller.tabIndex == 2 ? selectedMenuColor : unselectedTabColor,
          fontSize: 20,
          fontFamily: 'Roboto',
        ),
      ),
      label: "",
    );
  }

  AppBar _appBar(SessionController controller) {
    return AppBar(
      title: Text(controller.tabTitle),
      actions: [
        if (controller.tabTitle == "Home")
          IconButton(
            onPressed: () {
              Get.to(() => const SearchPage());
            },
            icon: const Icon(Icons.search, color: greySecondary),
          ),
        if (controller.tabTitle == "Profile")
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                barrierDismissible: true,
                radius: 6,
                contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                titlePadding: const EdgeInsets.only(top: 20),
                title: "Support",
                titleStyle: const TextStyle(color: selectedMenuColor),
                middleTextStyle: const TextStyle(color: greySecondary),
                middleText:
                    "Have any questions or suggestions? Write us on telegram!",
                textConfirm: "Send message",
                backgroundColor: backgroundDarkBlue,
                confirmTextColor: selectedMenuColor,
                buttonColor: selectedTabColor,
                onConfirm: () async {
                  await launchUrl(
                    Uri.parse("https://t.me/dionyusus"),
                    mode: LaunchMode.externalApplication,
                  );
                },
              );
            },
            icon: const Icon(Icons.info_outline_rounded, color: greySecondary),
          ),
      ],
      elevation: 0,
    );
  }

  AppBar _webAppBar(SessionController controller, Size screenSize) {
    return AppBar(
      // preferredSize: Size(screenSize.width, 60),
      flexibleSpace: BottomNavigationBar(
        selectedFontSize: 0,
        backgroundColor: const Color.fromARGB(255, 36, 47, 61),
        onTap: controller.changePage,
        currentIndex: controller.tabIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          _webHomePageItem(controller),
          _webCreatePageItem(controller),
          _webProfilePageItem(controller),
        ],
      ),
    );
  }
}
