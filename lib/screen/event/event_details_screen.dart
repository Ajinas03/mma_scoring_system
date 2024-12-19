import 'package:flutter/material.dart';
import 'package:mma_scoring_system/screen/common/app_bar_widgets.dart';
import 'package:mma_scoring_system/screen/common/text_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(title: "Event Name"),
      body: Column(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: "Score",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: "10",
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 1"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.9),
                      child: const Icon(Icons.person),
                    ),
                    title: const TextWidget(text: "Fighter 2"),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blue.withOpacity(0.9),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/Eg2ncutJOiAUTXbbRnFaJHlOBKIYl9-MFOga4QFdVgk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG5nbWFydC5jb20v/ZmlsZXMvMTYvSGFu/ZC1QdW5jaC1UcmFu/c3BhcmVudC1QTkcu/cG5n"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/8fuDW6c9gY3IbG0OCtsfu2l54YMDTn-8SYjOUlte2O0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZs/YXRpY29uLmNvbS81/MTIvMjkyOS8yOTI5/ODcxLnBuZw"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/QECvL-cPsIPU1Pp0ikidNm71m4YV5DbgolAIamrQc-c/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvbXVheS10aGFp/LzUxMi9NdWF5VGhh/aS0wOC0xMjgucG5n"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red.withOpacity(0.9),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/Eg2ncutJOiAUTXbbRnFaJHlOBKIYl9-MFOga4QFdVgk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cG5nbWFydC5jb20v/ZmlsZXMvMTYvSGFu/ZC1QdW5jaC1UcmFu/c3BhcmVudC1QTkcu/cG5n"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/8fuDW6c9gY3IbG0OCtsfu2l54YMDTn-8SYjOUlte2O0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZs/YXRpY29uLmNvbS81/MTIvMjkyOS8yOTI5/ODcxLnBuZw"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://imgs.search.brave.com/QECvL-cPsIPU1Pp0ikidNm71m4YV5DbgolAIamrQc-c/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvbXVheS10aGFp/LzUxMi9NdWF5VGhh/aS0wOC0xMjgucG5n"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: "+5",
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
