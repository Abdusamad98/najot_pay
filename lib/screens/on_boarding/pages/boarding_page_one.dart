import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/images/app_images.dart';

class BoardingPageOne extends StatelessWidget {
  const BoardingPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Image.asset(AppImages.boardingImage1),
          ),
          SizedBox(height: 50.h),
          Text(
            "The right relationship is everything.",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            "The right relationship is everything.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
