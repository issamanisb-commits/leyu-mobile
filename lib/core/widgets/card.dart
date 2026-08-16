import 'package:flutter/material.dart';
import 'package:leyu_mobile/core/widgets/image.dart';

import '../theme/app_colors.dart';

class CardWidget extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback onTap;
  final String? errorImageUrl;

  const CardWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
    this.errorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.gray),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(3, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            networkImageWidget(
                imageUrl: imageUrl ?? "",
                errorImageUrl: errorImageUrl ?? "category.svg",
                borderRadius: 10),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectableCardWidget extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? errorImageUrl;
  final bool isSelected;

  const SelectableCardWidget(
      {super.key,
      required this.name,
      this.imageUrl,
      required this.isSelected,
      this.errorImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: isSelected ? AppColors.green : AppColors.gray),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          networkImageWidget(
              imageUrl: imageUrl ?? "",
              errorImageUrl: errorImageUrl ?? "category.svg",
              borderRadius: 10),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.green : Theme.of(context).textTheme.bodyLarge?.color),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
