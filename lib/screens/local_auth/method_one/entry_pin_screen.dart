import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:najot_pay/blocs/auth/auth_bloc.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/data/models/forms_status.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/custom_keyboard_view.dart';
import 'package:najot_pay/screens/local_auth/method_one/widgets/pin_put_view.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/services/biometric_auth_service.dart';
import 'package:najot_pay/utils/styles/app_text_style.dart';
import 'package:pinput/pinput.dart';

class EntryPinScreen extends StatefulWidget {
  const EntryPinScreen({super.key});

  @override
  State<EntryPinScreen> createState() => _EntryPinScreenState();
}

class _EntryPinScreenState extends State<EntryPinScreen> {
  final TextEditingController pinPutController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  bool isError = false;

  String currentPin = "";

  bool biometricsEnabled = false;

  int attemptCount = 0;

  @override
  void initState() {
    biometricsEnabled = StorageRepository.getBool(key: "biometrics_enabled");
    currentPin = StorageRepository.getString(key: "pin_code");
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
            height: height / 10,
          ),
          Text(
            "Pin Kodni kiriting!",
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
            isError ? "Pin kod noto'g'ri!" : "",
            style: AppTextStyle.interMedium.copyWith(color: Colors.red),
          ),
          if (height > 700) SizedBox(height: 32.h),
          CustomKeyboardView(
            onFingerPrintTap: checkBiometrics,
            number: (number) {
              if (pinPutController.length < 4) {
                isError = false;
                pinPutController.text = "${pinPutController.text}$number";
              }
              if (pinPutController.length == 4) {
                if (currentPin == pinPutController.text) {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteNames.tabRoute,
                  );
                } else {
                  attemptCount++;
                  if (attemptCount == 3) {
                    context.read<AuthBloc>().add(LogOutUserEvent());
                  }
                  isError = true;
                  pinPutController.clear();
                }
                pinPutController.text = "";
              }
              setState(() {});
            },
            isBiometricsEnabled: biometricsEnabled,
            onClearButtonTap: () {
              if (pinPutController.length > 0) {
                pinPutController.text = pinPutController.text.substring(
                  0,
                  pinPutController.text.length - 1,
                );
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == FormsStatus.unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.authRoute,
                  (route) => false,
                );
              }
            },
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }

  Future<void> checkBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(
        context,
        RouteNames.tabRoute,
      );
    }
  }
}
