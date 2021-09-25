import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timato/enums/shared_pref_keys.dart';
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
      bottomNavigationBar: SafePadding(
        child: Row(
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
                    Get.off(() => MainScreen(), routeName: "main");
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
      ),
      body: Column(
        children: [
          Flexible(
            child: PageView(
              physics: PageScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) => currentPage.value = page,
              children: [
                SafePadding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Card(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElasticIn(
                          child: Icon(
                            FontAwesomeIcons.hourglass,
                            size: _iconSize,
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
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafePadding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElasticIn(
                          child: Icon(
                            FontAwesomeIcons.listAlt,
                            size: _iconSize,
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
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafePadding(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElasticIn(
                          child: Icon(
                            FontAwesomeIcons.sync,
                            size: _iconSize,
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
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
