import 'package:flutter/material.dart';

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
    // Add new item at the beginning of the list
    _items.insert(
        0,
        item ??
            MarkUpModel(
                type: "type",
                position: "position",
                marked: "marked",
                time: 10));
    _listKey.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 500));

    // Remove old items if exceeding maxItems
    if (_items.length > widget.maxItems) {
      final removedItem = _items.removeLast();
      _listKey.currentState?.removeItem(
        widget.maxItems,
        (context, animation) => _buildItem(context, removedItem, animation),
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  Widget _buildItem(
      BuildContext context, MarkUpModel item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text('Type: ${item.type}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Position: ${item.position}'),
                Text('Marked: ${item.marked}'),
                Text(
                    'Time: ${DateTime.fromMillisecondsSinceEpoch(item.time).toString()}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(context, _items[index], animation);
      },
    );
  }
}
