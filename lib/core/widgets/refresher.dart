import 'package:flutter/material.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';

class RefresherWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onRefresh;

  RefresherWidget({super.key, required this.child, required this.onRefresh});

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      header: const WaterDropHeader(),
      onRefresh: () {
        onRefresh();
        refreshController.refreshCompleted();
      },
      onLoading: () {
        refreshController.loadComplete();
      },
      child: child,
    );
  }
}
