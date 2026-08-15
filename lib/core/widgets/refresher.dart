import 'package:flutter/material.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';

class RefresherWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;

  const RefresherWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<RefresherWidget> createState() => _RefresherWidgetState();
}

class _RefresherWidgetState extends State<RefresherWidget> {
  late final RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(),
      onRefresh: () {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () {
        _refreshController.loadComplete();
      },
      child: widget.child,
    );
  }
}
