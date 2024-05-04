import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/custom_keyboard_view.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/pin_put_view.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';
import 'package:najot_pay/services/biometric_auth_service.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.previousPin});

  final String previousPin;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  bool biometricsEnabled = false;

  @override
  void initState() {
    BiometricAuthService.canAuthenticate().then((value) {
      if (value) {
        biometricsEnabled = true;
      }
    });
    super.initState();
  }

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
            "Pin kodni qayta kiriting!",
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
          Text(
            isError ? "Pin kod oldingisi bilan mos emas" : "",
            style: AppTextStyle.interMedium.copyWith(color: Colors.red),
          ),
          SizedBox(height: 32.h),
          CustomKeyboardView(
            onFingerPrintTap: () {},
            number: (number) {
              if (pinPutController.length < 4) {
                isError = false;
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (widget.previousPin == pinPutController.text) {
                  _setPin(pinPutController.text);
                } else {
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
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

  Future<void> _setPin(String pin) async {
    await StorageRepository.setString(
      key: "pin_code",
      value: pin,
    );

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      biometricsEnabled ? RouteNames.touchIdRoute : RouteNames.tabRoute,
      (route) => false,
    );
  }
}
