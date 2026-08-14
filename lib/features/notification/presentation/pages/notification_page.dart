import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';
import 'package:leyu_mobile/core/widgets/loading.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';
import '../controllers/notification_controller.dart';
import '../widgets/notification_date_section_widget.dart';
import '../widgets/notification_item_widget.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationController _controller = Get.find();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Obx(() => _buildBody()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      color: AppColors.appBgColor,
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.darkGray,
              size: 26,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'notifications.title'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          ),
          const SizedBox(width: 26),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_controller.isLoading.value) {
      return _buildLoadingState();
    }

    if (_controller.hasError.value && _controller.notifications.isEmpty) {
      return _buildErrorState();
    }

    if (_controller.notifications.isEmpty) {
      return _buildEmptyState();
    }

    return _buildNotificationList();
  }

  Widget _buildLoadingState() {
    return const Center(
      child: LoadingWidget(
        isTransparent: true,
        size: 40,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 50,
                color: AppColors.blue.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'notifications.empty_title'.tr,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.darkGray,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'notifications.empty_subtitle'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grayText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: AppColors.red.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _controller.errorMessage.value.isNotEmpty
                  ? _controller.errorMessage.value
                  : 'notifications.error_title'.tr,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.darkGray,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'notifications.error_subtitle'.tr,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.grayText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _controller.retryFetchNotifications(),
              icon: const Icon(Icons.refresh, size: 20),
              label: Text('notifications.retry'.tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: const WaterDropHeader(
        waterDropColor: AppColors.primary,
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const SizedBox.shrink();
          } else if (mode == LoadStatus.loading) {
            body = const LoadingWidget(
              isTransparent: true,
              size: 30,
              height: 60,
            );
          } else if (mode == LoadStatus.failed) {
            body = Text(
              'notifications.load_failed'.tr,
              style: const TextStyle(color: AppColors.grayText),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = Text(
              'notifications.release_to_load'.tr,
              style: const TextStyle(color: AppColors.grayText),
            );
          } else {
            body = Text(
              'notifications.no_more'.tr,
              style: const TextStyle(color: AppColors.grayText),
            );
          }
          return SizedBox(
            height: 60.0,
            child: Center(child: body),
          );
        },
      ),
      child: _buildGroupedNotifications(),
    );
  }

  Widget _buildGroupedNotifications() {
    final groupedNotifications = _controller.getGroupedNotifications();

    if (groupedNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: _calculateTotalItems(groupedNotifications),
      itemBuilder: (context, index) {
        return _buildGroupedItem(groupedNotifications, index);
      },
    );
  }

  int _calculateTotalItems(Map<String, List<dynamic>> groupedNotifications) {
    int total = 0;
    groupedNotifications.forEach((key, value) {
      total += 1; // For the date section header
      total += value.length; // For the notifications in this section
    });
    return total;
  }

  Widget _buildGroupedItem(
      Map<String, List<dynamic>> groupedNotifications, int index) {
    int currentIndex = 0;

    for (var entry in groupedNotifications.entries) {
      // Check if this index is the date section header
      if (currentIndex == index) {
        return NotificationDateSectionWidget(dateCategory: entry.key);
      }
      currentIndex++;

      // Check if this index is within the notifications for this date
      final notificationsInSection = entry.value.length;
      if (index < currentIndex + notificationsInSection) {
        final notificationIndex = index - currentIndex;
        final notification = entry.value[notificationIndex];
        return NotificationItemWidget(
          notification: notification,
          onTap: () {
            print('Notification tapped: ${notification.title}');
          },
        );
      }
      currentIndex += notificationsInSection;
    }

    return const SizedBox.shrink();
  }

  void _onRefresh() async {
    try {
      await _controller.refreshNotifications();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    try {
      if (_controller.hasMore.value) {
        await _controller.fetchNotifications(nextPage: true);
        if (_controller.hasMore.value) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else {
        _refreshController.loadNoData();
      }
    } catch (e) {
      _refreshController.loadFailed();
    }
  }
}
