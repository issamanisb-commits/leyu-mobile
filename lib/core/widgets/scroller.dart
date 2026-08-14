import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final List<Widget> children;

  const ScrollableWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildListDelegate(children),
          ),
        ),
      ],
    );
  }
}
