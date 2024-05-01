import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

import '../../../utils/styles/app_text_style.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({
    super.key,
    required this.onTap,
     this.readyToSubmit = true,
     this.isLoading = false,
    required this.title, required this.color, required this.subColor,
  });

  final VoidCallback onTap;
  final bool readyToSubmit;
  final bool isLoading;
  final String title;
  final Color color;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          backgroundColor:
              readyToSubmit ? color : subColor,
        ),
        onPressed: readyToSubmit ? onTap : null,
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 36.h,
                  width: 36.h,
                  child:
                      const CircularProgressIndicator.adaptive(strokeWidth: 5),
                )
              : Text(
                  title,
                  style: AppTextStyle.interSemiBold.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
