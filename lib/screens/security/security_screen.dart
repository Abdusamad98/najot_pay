import 'package:flutter/material.dart';
import 'package:najot_pay/data/local/storage_repository.dart';
import 'package:najot_pay/screens/security/widgets/settings_button.dart';
import 'package:najot_pay/services/biometric_auth_service.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
  });

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SecurityButton(
              isEnabled: StorageRepository.getBool(key: "biometrics_enabled"),
              onTap: () async {
                bool isEnabled =
                    StorageRepository.getBool(key: "biometrics_enabled");
                if (isEnabled) {
                  await StorageRepository.setBool(
                      key: "biometrics_enabled", value: false);
                } else {
                  bool authenticated =
                      await BiometricAuthService.authenticate();
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
                }

                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
