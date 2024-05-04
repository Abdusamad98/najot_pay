import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/custom_keyboard_view.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/pin_put_view.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height / 6,
          ),
          Text(
            "Pin Kodni o'rnating!",
            style: AppTextStyle.interSemiBold.copyWith(fontSize: 20),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: width / 2,
            child: PinPutTextView(
              isError: isError,
              pinPutFocusNode: focusNode,
              pinPutController: pinPutController,
            ),
          ),
          SizedBox(height: 32.h),
          CustomKeyboardView(
            onFingerPrintTap: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                Navigator.pushNamed(
                  context,
                  RouteNames.confirmPinRoute,
                  arguments: pinPutController.text,
                );
                pinPutController.text = "";
              }
            },
            isBiometricsEnabled: false,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                  0,
                  pinPutController.text.length - 1,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
