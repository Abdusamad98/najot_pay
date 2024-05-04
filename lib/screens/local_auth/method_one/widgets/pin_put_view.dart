import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/utils/colors/app_colors.dart';
import 'package:pinput/pinput.dart';

class PinPutTextView extends StatelessWidget {
  const PinPutTextView({
    super.key,
    required this.pinPutFocusNode,
    required this.pinPutController,
    required this.isError,
    this.onCompleted,
  });

  final FocusNode pinPutFocusNode;
  final TextEditingController pinPutController;
  final bool isError;
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 42.w,
      height: 42.w,
      textStyle: TextStyle(
          fontSize: 36.w,
          color: Theme.of(context).textTheme.displayLarge?.color),
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.38,
      child: Pinput(
        useNativeKeyboard: false,
        showCursor: false,
        length: 4,
        onCompleted: onCompleted,
        defaultPinTheme: defaultPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        errorPinTheme: PinTheme(
          width: 42.w,
          height: 42.w,
          textStyle: TextStyle(fontSize: 36.w, color: AppColors.c_2A3256),
        ),
        preFilledWidget: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        obscureText: true,
        obscuringWidget: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isError ? Colors.red : Colors.black,
          ),
        ),
        followingPinTheme: defaultPinTheme,
        pinAnimationType: PinAnimationType.scale,
      ),
    );
  }
}
