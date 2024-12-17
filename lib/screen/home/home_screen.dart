import 'package:flutter/material.dart';
import 'package:mma_scoring_system/screen/common/app_bar_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(title: "Home"),
      body: ListView(
        children: const [],
      ),
    );
  }
}
