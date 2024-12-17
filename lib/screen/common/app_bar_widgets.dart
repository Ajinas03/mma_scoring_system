import 'package:flutter/material.dart';
import 'package:mma_scoring_system/screen/common/text_widget.dart';

PreferredSizeWidget primaryAppBar({required String title}) {
  return AppBar(
    titleSpacing: 0,
    leadingWidth: 12,
    leading: const SizedBox.shrink(),
    title: TextWidget(text: title),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Badge(
              label: TextWidget(text: "0"), child: Icon(Icons.messenger_sharp)))
    ],
  );
}

PreferredSizeWidget secondaryAppBar({required String title}) {
  return AppBar(
    titleSpacing: 0,
    // leadingWidth: 12,
    // leading: const SizedBox.shrink(),
    title: TextWidget(text: title),
  );
}