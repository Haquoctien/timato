import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timato/constants/shared_pref_keys.dart';
import 'package:timato/screens/main_app/main_screen.dart';
import 'package:timato/services/shared_prefs.dart';
import 'package:timato/widgets/safe_padding.dart';

final currentPage = 0.obs;

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  final double _iconSize = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO
      //backgroundColor: Colors.white,
      bottomNavigationBar: SafePadding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      if (_pageController.page != 0)
                        _pageController.previousPage(
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          curve: Curves.ease,
                        );
                    },
                    child: Obx(
                      () => Text(
                        "Previous",
                        style: currentPage.value == 0 ? TextStyle(color: Colors.grey) : null,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.page == 2) {
                        SharedPref().it.setBool(SharedPrefKeys.isfirstTimeUser, false);
                        Get.off(
                          () => MainScreen(),
                          routeName: "main",
                        );
                      }
                      _pageController.nextPage(
                        duration: Duration(
                          milliseconds: 200,
                        ),
                        curve: Curves.ease,
                      );
                    },
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Hero(
              tag: "appname",
              child: Text(
                "Timato",
                // TODO
                style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: PageView(
              physics: PageScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) => currentPage.value = page,
              children: [
                SafePadding(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElasticIn(
                        child: Icon(
                          FontAwesomeIcons.hourglass,
                          size: _iconSize,
                          // TODO
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "Timer for your productivity",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
                SafePadding(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElasticIn(
                        child: Icon(
                          FontAwesomeIcons.listAlt,
                          size: _iconSize,
                          // TODO
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "Keep track and organise your tasks",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
                SafePadding(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElasticIn(
                        child: Icon(
                          FontAwesomeIcons.sync,
                          size: _iconSize,
                          // TODO
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          "Back up your data",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
