import 'package:flutter/material.dart';

class EntryPinScreen extends StatefulWidget {
  const EntryPinScreen({super.key});

  @override
  State<EntryPinScreen> createState() => _EntryPinScreenState();
}

class _EntryPinScreenState extends State<EntryPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Entry Pin Route"),),
    );
  }
}
