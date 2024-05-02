import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class AuthItem extends StatelessWidget {
  const AuthItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.routeName,
      required this.color,
      required this.subColor});

  final String title;
  final String subtitle;
  final String routeName;
  final Color color;
  final Color subColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyle.interRegular.copyWith(color: color),
        ),
        SizedBox(width: 5.w),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(routeName);
          },
          child: Text(
            subtitle,
            style: AppTextStyle.interRegular.copyWith(color: subColor),
          ),
        )
      ],
    );
  }
}
