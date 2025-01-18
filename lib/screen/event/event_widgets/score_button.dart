import 'package:flutter/material.dart';
import 'package:my_app/screen/common/text_widget.dart';

class ScoreButton extends StatelessWidget {
  final String heroTag;
  final VoidCallback onTap;
  final String title;
  const ScoreButton(
      {super.key,
      required this.heroTag,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        heroTag: heroTag,
        onPressed: () {
          onTap();
        },
        label: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://imgs.search.brave.com/Eg2ncutJOiAUTXbbRnFaJHlOBKIYl9-MFOga4QFdVgk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG5nbWFydC5jb20v/ZmlsZXMvMTYvSGFu/ZC1QdW5jaC1UcmFu/c3BhcmVudC1QTkcu/cG5n"),
            ),
            const SizedBox(
              width: 5,
            ),
            TextWidget(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )
          ],
        ));
  }
}
