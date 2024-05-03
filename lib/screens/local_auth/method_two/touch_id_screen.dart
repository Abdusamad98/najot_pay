import 'package:flutter/material.dart';
import 'package:najot_pay/screens/routes.dart';
import 'package:najot_pay/screens/widgets/my_custom_button.dart';

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
        title: Text("Touch ID Route"),
      ),
      body: Column(
        children: [
          MyCustomButton(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            },
            title: "Next",
          ),
        ],
      ),
    );
  }
}
