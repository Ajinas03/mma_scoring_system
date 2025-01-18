import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/config/screen_config.dart';
import 'package:my_app/models/login_model.dart';
import 'package:my_app/screen/common/app_bar_widgets.dart';
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/screen/event/event_details_screen.dart';
import 'package:my_app/screen/event/event_details_screen_admin.dart';

class EventScreen extends StatelessWidget {
  final LoginModel? loginModel;
  const EventScreen({super.key, required this.loginModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {},
            label: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 10,
                ),
                TextWidget(text: "Add Event"),
              ],
            )),
      ),
      appBar: primaryAppBar(title: "Events"),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                pushScreen(
                    context,
                    index.isEven
                        ? EventDetailsScreen(
                            loginModel: loginModel,
                          )
                        : const EventDetailsScreenAdmin());
              },
              title: const TextWidget(text: "Event Name"),
              subtitle: TextWidget(
                  text: DateFormat('dd MMM, yyyy').format(DateTime.now())),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle_rounded,
                    size: 12,
                    color: index != 0 ? null : Colors.green,
                  ),
                  const SizedBox(),
                  TextWidget(text: index != 0 ? "Inactive" : "Active")
                ],
              ),
            );
          }),
    );
  }
}
