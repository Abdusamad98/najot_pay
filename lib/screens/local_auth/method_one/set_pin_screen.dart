import 'package:flutter/material.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Pin Route"),),
      body: Column(
        children: [
          MyCustomButton(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.confirmPinRoute);
            },
            title: "Next",
          ),
        ],
      ),
    );
  }
}
