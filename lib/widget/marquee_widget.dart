import 'dart:async';

import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final int count;
  final IndexedWidgetBuilder itemBuilder;
  final int duration;

  const MarqueeWidget({super.key, required this.count, required this.itemBuilder, this.duration = 3});

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late PageController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(Duration(seconds: widget.duration), (timer) {
      if (_controller.page != null) {
        if (_controller.page!.round() >= widget.count) {
          _controller.jumpToPage(0);
        }
        _controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      controller: _controller,
      itemBuilder: (buildContext, index) {
        if (index < widget.count) {
          return widget.itemBuilder(buildContext, index);
        } else {
          return widget.itemBuilder(buildContext, 0);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }
}
