import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class AuthItem extends StatelessWidget {
  const AuthItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.subColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final Color subColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyle.interRegular.copyWith(color: color),
          ),
          SizedBox(width: 5.w),
          Text(
            subtitle,
            style: AppTextStyle.interRegular.copyWith(color: subColor),
          )
        ],
      ),
    );
  }
}
