import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/logic/connection/connection_bloc.dart' as ct;
import 'package:my_app/screen/common/text_widget.dart';
import 'package:my_app/utils/competetion_utils.dart';

import '../../../models/mark_up_model.dart';

class AnimatedMarkupList extends StatefulWidget {
  final MarkUpModel? newItem;
  final int maxItems; // Maximum number of items to show in the list

  const AnimatedMarkupList({
    super.key,
    required this.newItem,
    this.maxItems = 5, // Default to showing 5 items
  });

  @override
  State<AnimatedMarkupList> createState() => _AnimatedMarkupListState();
}

class _AnimatedMarkupListState extends State<AnimatedMarkupList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<MarkUpModel> _items = [];

  @override
  void didUpdateWidget(AnimatedMarkupList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.newItem != oldWidget.newItem) {
      _addItem(widget.newItem);
    }
  }

  void _addItem(MarkUpModel? item) {
    if (item != null) {
      // Add new item at the beginning of the list
      _items.insert(0, item);
      _listKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 500));
    }
  }

  // Function to calculate total score
  int _calculateScore(bool isRed) {
    return _items.where((item) => item.ismarkedToRed == isRed).fold(
        0,
        (previousValue, item) =>
            previousValue + (int.tryParse(item.marked) ?? 0));
  }

  Widget _buildItem(
      BuildContext context, MarkUpModel item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: item.ismarkedToRed
                ? Colors.red.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Player avatar
              CircleAvatar(
                radius: 20, // Reduced avatar size
                backgroundColor: item.ismarkedToRed ? Colors.red : Colors.blue,
                child: Icon(
                  Icons.sports_mma,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Score Title
                    Text(
                      item.ismarkedToRed
                          ? "Red scored: ${item.marked}"
                          : "Blue scored: ${item.marked}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    // Position and Time Row
                    Row(
                      children: [
                        Text(
                          'By: ${item.position}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          timeAgo(item.time),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int redScore = _calculateScore(true); // Calculate total score for Red
    int blueScore = _calculateScore(false); // Calculate total score for Blue

    print(
        "red score $redScore  bluee $blueScore   bool :: ${(redScore == 0 && blueScore == 0)}");

    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(context, _items[index], animation);
            },
          ),
        ),
        // Score Display at the bottom
        BlocBuilder<ct.ConnectionBloc, ct.ConnectionState>(
          builder: (context, state) {
            return state.sessionModel?.duration != 0
                ? SizedBox.shrink()
                : (redScore == 0 && blueScore == 0)
                    ? SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IntrinsicHeight(
                              // This helps align the divider properly
                              child: Row(
                                children: [
                                  // Red Player Score
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Red Total",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "$redScore",
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Vertical Divider
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    child: VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  ),
                                  // Blue Player Score
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Blue Total",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "$blueScore",
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            TextWidget(
                              text: "Game Over!!",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            SizedBox(height: 8),
                            // Analytics Button with gradient
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle analytics button action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ).copyWith(
                                  elevation:
                                      WidgetStateProperty.resolveWith<double>(
                                    (Set<WidgetState> states) {
                                      if (states.contains(WidgetState.pressed))
                                        return 2;
                                      return 4;
                                    },
                                  ),
                                ),
                                child: Text(
                                  "View Analytics",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
          },
        )
      ],
    );
  }
}
