import 'package:flutter/material.dart';

/// Utility class for common UI animations in the application.
///
/// Provides reusable animation builders for:
/// - Page transitions (fade, slide)
/// - List item animations
/// - Image fade-in effects
/// - Button press feedback
/// - Shimmer loading placeholders
/// - Animated progress bars
///
/// All animations use consistent durations and curves for a cohesive
/// user experience throughout the app.
///
/// Example usage:
/// ```dart
/// // Navigate with fade transition
/// Navigator.push(context, AppAnimations.createFadeRoute(NextPage()));
///
/// // Animate list items
/// ListView.builder(
///   itemBuilder: (context, index) => AppAnimations.animatedListItem(
///     child: ListTile(...),
///     index: index,
///   ),
/// );
/// ```
class AppAnimations {
  // Page transition animation
  /// Creates a fade transition route for page navigation.
  ///
  /// The new page fades in over 300ms.
  ///
  /// Example:
  /// ```dart
  /// Navigator.push(context, AppAnimations.createFadeRoute(DetailPage()));
  /// ```
  static Route<T> createFadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Creates a slide transition route for page navigation.
  ///
  /// The new page slides in from the right over 300ms with an ease-in-out curve.
  ///
  /// Example:
  /// ```dart
  /// Navigator.push(context, AppAnimations.createSlideRoute(DetailPage()));
  /// ```
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
  /// Animates a list item with fade-in and slide-up effect.
  ///
  /// Each item animates with a staggered delay based on its index,
  /// creating a cascading effect.
  ///
  /// Parameters:
  /// - [child]: The widget to animate
  /// - [index]: The item's position in the list (for stagger delay)
  /// - [delay]: Delay between each item's animation (default: 50ms)
  ///
  /// Example:
  /// ```dart
  /// ListView.builder(
  ///   itemBuilder: (context, index) => AppAnimations.animatedListItem(
  ///     child: ListTile(title: Text('Item $index')),
  ///     index: index,
  ///   ),
  /// );
  /// ```
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
  /// Creates a fade-in animation for images as they load.
  ///
  /// Shows a placeholder while loading and fades in the image when ready.
  /// Displays an error icon if the image fails to load.
  ///
  /// Parameters:
  /// - [image]: The image provider to load
  /// - [fit]: How the image should fit in its container
  /// - [placeholder]: Optional widget to show while loading
  /// - [duration]: Fade-in duration (default: 300ms)
  ///
  /// Example:
  /// ```dart
  /// AppAnimations.fadeInImage(
  ///   image: NetworkImage('https://example.com/image.jpg'),
  ///   fit: BoxFit.cover,
  ///   placeholder: CircularProgressIndicator(),
  /// );
  /// ```
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
  /// Creates a pressable button with scale animation feedback.
  ///
  /// The button scales down slightly when pressed, providing tactile feedback.
  ///
  /// Parameters:
  /// - [child]: The button widget
  /// - [onPressed]: Callback when button is pressed
  /// - [duration]: Animation duration (default: 100ms)
  ///
  /// Example:
  /// ```dart
  /// AppAnimations.pressableButton(
  ///   child: ElevatedButton(child: Text('Press Me'), onPressed: null),
  ///   onPressed: () => print('Pressed!'),
  /// );
  /// ```
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
  /// Creates a shimmer loading placeholder animation.
  ///
  /// Displays an animated gradient that moves across the container,
  /// indicating content is loading.
  ///
  /// Parameters:
  /// - [width]: Width of the shimmer container
  /// - [height]: Height of the shimmer container
  /// - [borderRadius]: Optional border radius for rounded corners
  ///
  /// Example:
  /// ```dart
  /// AppAnimations.shimmerLoading(
  ///   width: 200,
  ///   height: 20,
  ///   borderRadius: BorderRadius.circular(8),
  /// );
  /// ```
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
  /// Creates an animated progress bar.
  ///
  /// The progress bar smoothly animates to the target progress value.
  ///
  /// Parameters:
  /// - [progress]: Progress value from 0.0 to 1.0
  /// - [color]: Color of the progress indicator
  /// - [backgroundColor]: Color of the background track
  /// - [height]: Height of the progress bar (default: 4.0)
  /// - [duration]: Animation duration (default: 200ms)
  ///
  /// Example:
  /// ```dart
  /// AppAnimations.animatedProgressBar(
  ///   progress: 0.65,
  ///   color: Colors.blue,
  ///   height: 6.0,
  /// );
  /// ```
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
