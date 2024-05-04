import 'package:flutter/material.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';
import 'package:najot_pay/services/biometric_auth_service.dart';

class TouchIdScreen extends StatefulWidget {
  const TouchIdScreen({super.key});

  @override
  State<TouchIdScreen> createState() => _TouchIdScreenState();
}

class _TouchIdScreenState extends State<TouchIdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Touch ID Route"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint,
                size: 150,
                color: Colors.blue,
              ),
              Icon(
                Icons.face,
                size: 150,
                color: Colors.blue,
              ),
            ],
          ),
          MyCustomButton(
            onTap: enableBiometrics,
            title: "Biometrics Auth",
          ),
          MyCustomButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            },
            title: "Skip",
          ),
        ],
      ),
    );
  }

  Future<void> enableBiometrics() async {
    bool authenticated = await BiometricAuthService.authenticate();
    if (authenticated) {
      await StorageRepository.setBool(
        key: "biometrics_enabled",
        value: true,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Biometrics Enabled"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Biometrics ERROR!"),
        ),
      );
    }
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouteNames.tabRoute,
      (route) => false,
    );
  }
}
