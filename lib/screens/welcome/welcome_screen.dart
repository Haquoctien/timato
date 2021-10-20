import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/constants/shared_pref_keys.dart';
import 'package:timato/main_app.dart';
import 'package:timato/services/shared_prefs.dart';
import 'package:timato/widgets/safe_padding.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  final double _iconSize = 100;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafePadding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: ExpandingDotsEffect(
                activeDotColor: AppTheme.fg,
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
                    child: Text(
                      "Previous",
                      style: currentPage == 0 ? TextStyle(color: Colors.grey) : null,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.page == 1) {
                        SharedPref().it.setBool(SharedPrefKeys.isfirstTimeUser, false);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MainApp(),
                          ),
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
                style: Theme.of(context).textTheme.headline4?.copyWith(color: AppTheme.text.fgColor),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: PageView(
              physics: PageScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) => setState(() {
                currentPage = page;
              }),
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
                          style: TextStyle(color: AppTheme.text.fgColor),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
