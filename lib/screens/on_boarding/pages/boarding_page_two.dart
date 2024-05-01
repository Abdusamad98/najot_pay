import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/images/app_images.dart';

class BoardingPageTwo extends StatelessWidget {
  const BoardingPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(AppImages.boardingImage2),
          ),
          SizedBox(height: 50.h),
          Text(
            "Your Financial Partner for Life: Citibank.",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            "Where Your Financial Goals Become Reality.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
