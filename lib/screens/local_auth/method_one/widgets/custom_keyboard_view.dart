import 'dart:io';

import 'package:flutter/material.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';

class CustomKeyboardView extends StatelessWidget {
  const CustomKeyboardView({
    super.key,
    required this.number,
    required this.isBiometricsEnabled,
    required this.onClearButtonTap,
    required this.onFingerPrintTap,
  });

  final ValueChanged<String> number;
  final bool isBiometricsEnabled;
  final VoidCallback onClearButtonTap;
  final VoidCallback onFingerPrintTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 32,
        mainAxisSpacing: 0,
        crossAxisCount: 3,
        children: [
          ...List.generate(
            9,
            (index) {
              return IconButton(
                onPressed: () {
                  number.call("${index + 1}");
                },
                icon: Text(
                  "${index + 1}",
                  style: AppTextStyle.interBold.copyWith(fontSize: 24),
                ),
              );
            },
          ),
          Visibility(
            visible: isBiometricsEnabled,
            child: IconButton(
              onPressed: onFingerPrintTap,
              icon: Icon(Platform.isAndroid ? Icons.fingerprint : Icons.face),
            ),
          ),
          IconButton(
            onPressed: () {
              number.call("0");
            },
            icon: Text(
              "0",
              style: AppTextStyle.interBold.copyWith(fontSize: 24),
            ),
          ),
          IconButton(
            onPressed: onClearButtonTap,
            icon: const Icon(Icons.backspace),
          ),
        ],
      ),
    );
  }
}
