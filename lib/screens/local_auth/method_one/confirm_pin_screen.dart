import 'package:flutter/material.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ConfirmPinScreen"),
      ),
      body: Column(
        children: [
          MyCustomButton(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.touchIdRoute);
            },
            title: "Next",
          ),
        ],
      ),
    );
  }
}
