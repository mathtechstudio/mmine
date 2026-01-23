import 'package:flutter/material.dart';

class AppAnimations {
  // Page transition animation
  static Route<T> createFadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<T> createSlideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // List item animation
  static Widget animatedListItem({
    required Widget child,
    required int index,
    Duration delay = const Duration(milliseconds: 50),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * delay.inMilliseconds)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Fade in animation for images
  static Widget fadeInImage({
    required ImageProvider image,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return Image(
      image: image,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;

        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: duration,
          curve: Curves.easeIn,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return placeholder ??
            Container(
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey[400]),
            );
      },
    );
  }

  // Button press feedback animation
  static Widget pressableButton({
    required Widget child,
    required VoidCallback onPressed,
    Duration duration = const Duration(milliseconds: 100),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.0),
      duration: duration,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: (_) {
              // Trigger scale down animation
            },
            onTapUp: (_) {
              onPressed();
            },
            onTapCancel: () {
              // Trigger scale up animation
            },
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Shimmer loading animation
  static Widget shimmerLoading({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1.0, end: 2.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment(value - 1, 0),
              end: Alignment(value, 0),
              colors: [Colors.grey[300]!, Colors.grey[200]!, Colors.grey[300]!],
            ),
          ),
        );
      },
    );
  }

  // Progress bar animation
  static Widget animatedProgressBar({
    required double progress,
    Color? color,
    Color? backgroundColor,
    double height = 4.0,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: AnimatedFractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        alignment: Alignment.centerLeft,
        duration: duration,
        curve: Curves.easeInOut,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.blue,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
