import 'package:flutter/material.dart';
import 'package:mmine/core/utils/animations.dart';

class SkeletonTrackTile extends StatelessWidget {
  const SkeletonTrackTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppAnimations.shimmerLoading(
        width: 48,
        height: 48,
        borderRadius: BorderRadius.circular(4),
      ),
      title: AppAnimations.shimmerLoading(width: double.infinity, height: 16),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: AppAnimations.shimmerLoading(width: 150, height: 12),
      ),
      trailing: AppAnimations.shimmerLoading(width: 40, height: 12),
    );
  }
}
