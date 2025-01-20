import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({super.key});

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView> {
  final List<int> _points = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAddingPoints();
  }

  void _startAddingPoints() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final newPoint = (_points.isNotEmpty ? _points.last : 0) + 1;
      _points.add(newPoint);
      _listKey.currentState?.insertItem(_points.length - 1);
      _autoScrollToEnd();
    });
  }

  void _autoScrollToEnd() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _removePoint(int index) {
    final removedPoint = _points.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedPoint, animation, false),
    );
  }

  Widget _buildItem(int point, Animation<double> animation, bool isVisible) {
    return FadeTransition(
      opacity: animation,
      child: Transform.translate(
        offset: Offset(0, isVisible ? 0 : 20),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          elevation: 5,
          child: ListTile(
            title: Text(
              'Point: $point',
              style: const TextStyle(fontSize: 18),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                final index = _points.indexOf(point);
                if (index != -1) _removePoint(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Animated List View')),
      body: AnimatedList(
        key: _listKey,
        controller: _scrollController,
        initialItemCount: _points.length,
        itemBuilder: (context, index, animation) {
          final isVisible =
              index >= _points.length - 3; // Highlight recent items
          return _buildItem(_points[index], animation, isVisible);
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_timer == null) {
      //       _startAddingPoints();
      //     } else {
      //       _timer?.cancel();
      //       _timer = null;
      //     }
      //     setState(() {});
      //   },
      //   child: Icon(_timer == null ? Icons.play_arrow : Icons.pause),
      // ),
    );
  }
}
