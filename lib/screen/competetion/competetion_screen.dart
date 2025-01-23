import 'package:flutter/material.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/competetion/create_competetion_screen.dart';

class CompetetionScreen extends StatelessWidget {
  const CompetetionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushReplaceScreen(context, CreateCompetitionScreen());
        },
        child: Icon(Icons.add),
      ),
      appBar: secondaryAppBar(title: "Competetions"),
    );
  }
}
