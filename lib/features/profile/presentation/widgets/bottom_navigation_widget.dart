import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leyu_mobile/core/theme/app_colors.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: 'common.nav.home'.tr,
              index: 0,
              isSelected: currentIndex == 0,
            ),
            _buildNavItem(
              icon: Icons.task,
              label: 'common.nav.tasks'.tr,
              index: 1,
              isSelected: currentIndex == 1,
            ),
            _buildNavItem(
              icon: Icons.list_alt,
              label: 'common.nav.submission'.tr,
              index: 2,
              isSelected: currentIndex == 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.grayText,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? AppColors.primary : AppColors.grayText,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
