import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';
import 'package:leyu_mobile/features/notification/domain/entities/notification_entity.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onTap,
  });

  /// Get notification icon path based on type
  String _getNotificationIcon() {
    switch (notification.type.toLowerCase()) {
      case 'task-assign':
      case 'task-assigned':
        return 'assets/images/notification_assigned.svg';
      case 'task-rejected':
        return 'assets/images/notification_rejected.svg';
      case 'task-approved':
        return 'assets/images/notification_approved.svg';
      default:
        return 'assets/images/notification.svg';
    }
  }

  /// Get notification background color based on type
  Color _getNotificationBgColor() {
    switch (notification.type.toLowerCase()) {
      case 'task-assign':
      case 'task-assigned':
        return AppColors.lightBlue; // Blue background
      case 'task-rejected':
        return const Color(0xFFFFEBEE); // Light red background
      case 'task-approved':
        return const Color(0xFFE8F5E9); // Light green background
      default:
        return AppColors.lightBlue;
    }
  }

  /// Get notification icon color based on type
  Color _getNotificationIconColor() {
    switch (notification.type.toLowerCase()) {
      case 'task-assign':
      case 'task-assigned':
        return AppColors.blue;
      case 'task-rejected':
        return AppColors.red;
      case 'task-approved':
        return AppColors.green;
      default:
        return AppColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: AppColors.gray,
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification icon
            Center(
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: _getNotificationBgColor(),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    _getNotificationIcon(),
                    width: 18.0,
                    height: 18.0,
                    colorFilter: ColorFilter.mode(
                      _getNotificationIconColor(),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Message
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: AppColors.grayText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6.0),
                  // Timestamp
                  Text(
                    notification.getFormattedDateTime(),
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: AppColors.grayText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            // Read/Unread indicator (blue dot)
            if (!notification.isRead)
              Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.only(top: 6.0),
                decoration: const BoxDecoration(
                  color: AppColors.blue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
