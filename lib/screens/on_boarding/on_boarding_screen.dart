import 'package:flutter/material.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/screens/on_boarding/pages/boarding_page_one.dart';
import 'package:najot_pay/screens/on_boarding/pages/boarding_page_three.dart';
import 'package:najot_pay/screens/on_boarding/pages/boarding_page_two.dart';
import 'package:najot_pay/screens/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (index) {},
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BoardingPageOne(),
                BoardingPageTwo(),
                BoardingPageThree(),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (activeIndex == 2) {
                StorageRepository.setBool(
                  key: "is_new_user",
                  value: true,
                ).then(
                  (value) {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.authRoute);
                  },
                );
              } else {
                activeIndex += 1;
                controller.animateToPage(
                  activeIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              }
            },
            child: Text("Next"),
          )
        ],
      ),
    );
  }
}
