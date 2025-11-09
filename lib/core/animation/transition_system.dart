import 'package:flutter/material.dart';
import 'app_motion.dart';

/// TransitionSystem - Foundational animation infrastructure
/// 
/// Provides modular, reusable transitions and iOS-style motion consistency.
/// All animations sync with AppMotion durations and AppCurves for uniformity.
/// 
/// Design Philosophy:
/// - Natural, subtle motion (no exaggeration)
/// - Smooth perception over dramatic effects
/// - Performance-optimized for production use
/// - Ready for Firestore integration and live content
/// 
/// Usage Example:
/// ```dart
/// Navigator.of(context).push(
///   TransitionSystem.fadePush(const DetailsScreen()),
/// );
/// ```

// ==================== Transition Wrappers ====================

/// FadeTransitionWrapper - Smooth opacity transitions
/// 
/// Use for: Content switches, overlays, modal appearances
/// 
/// Example:
/// ```dart
/// AnimatedSwitcher(
///   duration: AppMotion.normal,
///   child: FadeTransitionWrapper(child: Text('Hello')),
/// )
/// ```
class FadeTransitionWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const FadeTransitionWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration,
      curve: curve,
      child: child,
    );
  }

  /// Creates a transition builder for AnimatedSwitcher
  static Widget transitionBuilder(Widget child, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/// SlideTransitionWrapper - Directional slide animations
/// 
/// Supports horizontal and vertical sliding with customizable direction.
/// 
/// Use for: Drawers, panels, bottom sheets, side navigation
/// 
/// Example:
/// ```dart
/// SlideTransitionWrapper(
///   direction: SlideDirection.fromBottom,
///   child: MyWidget(),
/// )
/// ```
class SlideTransitionWrapper extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration duration;
  final Curve curve;

  const SlideTransitionWrapper({
    super.key,
    required this.child,
    this.direction = SlideDirection.fromRight,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  State<SlideTransitionWrapper> createState() => _SlideTransitionWrapperState();
}

class _SlideTransitionWrapperState extends State<SlideTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: widget.direction.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }

}

/// Slide direction enumeration
enum SlideDirection {
  fromLeft(Offset(-1.0, 0.0)),
  fromRight(Offset(1.0, 0.0)),
  fromTop(Offset(0.0, -1.0)),
  fromBottom(Offset(0.0, 1.0));

  final Offset offset;
  const SlideDirection(this.offset);
}

/// AnimatedContainerWrapper - Responsive motion for UI state changes
/// 
/// Automatically animates changes to padding, margin, color, and size.
/// 
/// Use for: Collapsing headers, expanding cards, responsive layouts
/// 
/// Example:
/// ```dart
/// AnimatedContainerWrapper(
///   isExpanded: true,
///   collapsedHeight: 60,
///   expandedHeight: 200,
///   child: MyContent(),
/// )
/// ```
class AnimatedContainerWrapper extends StatelessWidget {
  final Widget child;
  final bool isExpanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Color? color;
  final Duration duration;
  final Curve curve;

  const AnimatedContainerWrapper({
    super.key,
    required this.child,
    this.isExpanded = true,
    this.collapsedHeight = 60,
    this.expandedHeight = 200,
    this.color,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      height: isExpanded ? expandedHeight : collapsedHeight,
      color: color,
      child: child,
    );
  }
}

/// HeroTransitionWrapper - Shared element transitions
/// 
/// Seamless animation between screens for related content.
/// 
/// Use for: Image galleries, detail views, card expansions
/// 
/// Example:
/// ```dart
/// HeroTransitionWrapper(
///   tag: 'case-123',
///   child: CaseCard(),
/// )
/// ```
class HeroTransitionWrapper extends StatelessWidget {
  final Object tag;
  final Widget child;
  final CreateRectTween? createRectTween;
  final HeroFlightShuttleBuilder? flightShuttleBuilder;

  const HeroTransitionWrapper({
    super.key,
    required this.tag,
    required this.child,
    this.createRectTween,
    this.flightShuttleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      child: child,
    );
  }

  /// Default tween with smooth material arc
  static RectTween createDefaultRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }
}

// ==================== Navigation Transitions ====================

/// TransitionSystem - Core navigation transition utilities
class TransitionSystem {
  TransitionSystem._();

  // ==================== Fade Transitions ====================

  /// Fade push transition
  /// 
  /// Smoothly fades in the new screen while fading out the old.
  /// 
  /// Example:
  /// ```dart
  /// Navigator.push(
  ///   context,
  ///   TransitionSystem.fadePush(const ProfileScreen()),
  /// );
  /// ```
  static PageRoute<T> fadePush<T>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionDuration: duration ?? AppMotion.normal,
      reverseTransitionDuration: duration ?? AppMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  /// Fade pop transition
  /// 
  /// Returns to previous screen with fade effect.
  static void fadePop(BuildContext context) {
    Navigator.of(context).pop();
  }

  // ==================== Slide Transitions ====================

  /// Slide push transition
  /// 
  /// Slides new screen from specified direction.
  /// 
  /// Example:
  /// ```dart
  /// Navigator.push(
  ///   context,
  ///   TransitionSystem.slidePush(
  ///     const ChatScreen(),
  ///     direction: SlideDirection.fromRight,
  ///   ),
  /// );
  /// ```
  static PageRoute<T> slidePush<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration? duration,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionDuration: duration ?? AppMotion.normal,
      reverseTransitionDuration: duration ?? AppMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: direction.offset,
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: AppCurves.smooth,
          )),
          child: child,
        );
      },
    );
  }

  /// Slide pop transition
  /// 
  /// Returns to previous screen with slide effect.
  static void slidePop(BuildContext context) {
    Navigator.of(context).pop();
  }

  // ==================== Shared Axis Transition ====================

  /// Shared axis transition
  /// 
  /// Material Design 3 style transition with fade + slide.
  /// Provides smooth continuity between related screens.
  /// 
  /// Example:
  /// ```dart
  /// Navigator.push(
  ///   context,
  ///   TransitionSystem.sharedAxisTransition(
  ///     const CaseDetailScreen(),
  ///   ),
  /// );
  /// ```
  static PageRoute<T> sharedAxisTransition<T>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionDuration: duration ?? AppMotion.normal,
      reverseTransitionDuration: duration ?? AppMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade in with delay for smooth appearance
        final fadeIn = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.3, 1.0, curve: Curves.easeInOutCubic),
        ));

        // Slide up slightly
        final slide = Tween<Offset>(
          begin: const Offset(0.0, 0.05),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.emphasizedEnter,
        ));

        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: fadeIn,
            child: child,
          ),
        );
      },
    );
  }

  // ==================== Modal Transition ====================

  /// Modal transition with blur and opacity overlay
  /// 
  /// Bottom sheet style modal with backdrop blur effect.
  /// 
  /// Example:
  /// ```dart
  /// Navigator.push(
  ///   context,
  ///   TransitionSystem.modalTransition(
  ///     const AddCaseModal(),
  ///   ),
  /// );
  /// ```
  static PageRoute<T> modalTransition<T>(
    Widget page, {
    Duration? duration,
    RouteSettings? settings,
    bool opaque = false,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      opaque: opaque,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      transitionDuration: duration ?? AppMotion.normal,
      reverseTransitionDuration: duration ?? AppMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Scale + fade for modal appearance
        final scale = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.elastic,
        ));

        final fade = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.smooth,
        ));

        return ScaleTransition(
          scale: scale,
          child: FadeTransition(
            opacity: fade,
            child: child,
          ),
        );
      },
    );
  }

  // ==================== Custom Transition Builder ====================

  /// Custom transition builder
  /// 
  /// Allows creating fully custom transitions with any combination of effects.
  /// 
  /// Example:
  /// ```dart
  /// Navigator.push(
  ///   context,
  ///   TransitionSystem.customTransition(
  ///     const MyScreen(),
  ///     builder: (context, animation, secondaryAnimation, child) {
  ///       return FadeTransition(
  ///         opacity: animation,
  ///         child: RotationTransition(
  ///           turns: animation,
  ///           child: child,
  ///         ),
  ///       );
  ///     },
  ///   ),
  /// );
  /// ```
  static PageRoute<T> customTransition<T>(
    Widget page, {
    required RouteTransitionsBuilder builder,
    Duration? duration,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings,
      transitionDuration: duration ?? AppMotion.normal,
      reverseTransitionDuration: duration ?? AppMotion.normal,
      transitionsBuilder: builder,
    );
  }
}

// ==================== Animation Helpers ====================

/// AnimationHelpers - Utility extensions for common animation patterns
extension AnimationHelpers on Widget {
  /// Wraps widget with fade animation
  Widget withFade({
    Duration? duration,
    Curve? curve,
  }) {
    return FadeTransitionWrapper(
      duration: duration ?? AppMotion.normal,
      curve: curve ?? AppCurves.smooth,
      child: this,
    );
  }

  /// Wraps widget with slide animation
  Widget withSlide({
    SlideDirection direction = SlideDirection.fromBottom,
    Duration? duration,
    Curve? curve,
  }) {
    return SlideTransitionWrapper(
      direction: direction,
      duration: duration ?? AppMotion.normal,
      curve: curve ?? AppCurves.smooth,
      child: this,
    );
  }

  /// Wraps widget with Hero transition
  Widget withHero(Object tag) {
    return HeroTransitionWrapper(
      tag: tag,
      child: this,
    );
  }
}

// ==================== Staggered Animation Helper ====================

/// StaggeredAnimationHelper - Creates staggered list animations
/// 
/// Animates list items with sequential delays for polished effect.
/// 
/// Example:
/// ```dart
/// ListView.builder(
///   itemCount: items.length,
///   itemBuilder: (context, index) {
///     return StaggeredAnimationHelper(
///       index: index,
///       child: ListTile(title: Text(items[index])),
///     );
///   },
/// )
/// ```
class StaggeredAnimationHelper extends StatelessWidget {
  final int index;
  final Widget child;
  final Duration delay;
  final Duration duration;

  const StaggeredAnimationHelper({
    super.key,
    required this.index,
    required this.child,
    this.delay = const Duration(milliseconds: 50),
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: AppCurves.smooth,
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
}
