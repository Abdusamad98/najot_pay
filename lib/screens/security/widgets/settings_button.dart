import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecurityButton extends StatelessWidget {
  const SecurityButton({
    super.key,
    required this.isEnabled,
    required this.onTap,
  });

  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Biometrics"),
          CupertinoSwitch(
            onChanged: (v) {
              onTap.call();
            },
            value: isEnabled,
          )
        ],
      ),
    );
  }
}
