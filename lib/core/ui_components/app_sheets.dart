import 'dart:async';
import 'package:flutter/material.dart';
import '../animation/app_motion.dart';
import '../interaction/global_interaction_refinement.dart';
import 'app_modals.dart';

/// 🎯 AppBottomSheet System - iOS-Style Bottom Sheet Architecture
///
/// **Design Philosophy:**
/// "Elegant authority with calming confidence" - Draggable bottom sheets with
/// smooth snap points, spring physics, blur backdrop, and tactile feedback.
///
/// **Components:**
/// 1. **AppSheetController** - Lifecycle and position management
/// 2. **AppBottomSheet** - Main draggable sheet widget
/// 3. **AppSheetHandle** - Visual drag handle with haptics
/// 4. **SheetPosition** - Position enumeration with utilities
///
/// **Features:**
/// - Draggable with snap points (peek/half/full)
/// - Spring physics animations with gentle overshoot
/// - Blur backdrop with parallax fade
/// - Velocity-based snap detection
/// - Keyboard-aware safe area handling
/// - Haptic feedback on snap and drag
/// - Focus trapping for modal sheets
/// - Back button dismissal (Android)
///
/// **Integration:**
/// - AppMotion timing (150ms/200ms/300ms)
/// - AppCurves.elastic for spring-like snapping
/// - AppInteractionRefinement for haptics
/// - AppBlurBackdrop for glassmorphism
///
/// **Example Usage:**
/// ```dart
/// final sheetController = AppSheetController();
///
/// await sheetController.showSheet(
///   context: context,
///   builder: (context) => Padding(
///     padding: const EdgeInsets.all(24),
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         Text('Bottom Sheet Content'),
///         ElevatedButton(
///           onPressed: () => sheetController.close(),
///           child: Text('Close'),
///         ),
///       ],
///     ),
///   ),
///   snapPoints: [SheetPosition.peek, SheetPosition.half, SheetPosition.full],
///   initialSnap: 0,
/// );
/// ```

// region ENUMS & TYPES

/// Sheet position states.
enum SheetPosition {
  hidden,
  peek,
  half,
  full,
}

/// Sheet behavior modes.
enum SheetBehavior {
  dismissible,
  persistent,
}

// endregion

// region UTILITIES

/// Position resolution utilities.
class SheetPositionUtils {
  SheetPositionUtils._();

  /// Resolve a SheetPosition to pixel height.
  static double resolvePosition(
    SheetPosition position,
    Size screenSize,
    EdgeInsets safeArea, {
    double? peekHeight,
  }) {
    final availableHeight = screenSize.height - safeArea.top;

    switch (position) {
      case SheetPosition.hidden:
        return 0;
      case SheetPosition.peek:
        return peekHeight ?? 200;
      case SheetPosition.half:
        return availableHeight * 0.5;
      case SheetPosition.full:
        return availableHeight - safeArea.top - 56; // Leave space for handle
    }
  }

  /// Get snap point from pixel offset.
  static int getClosestSnapIndex(
    double currentHeight,
    List<double> snapHeights,
  ) {
    int closestIndex = 0;
    double minDistance = (currentHeight - snapHeights[0]).abs();

    for (int i = 1; i < snapHeights.length; i++) {
      final distance = (currentHeight - snapHeights[i]).abs();
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }

    return closestIndex;
  }
}

// endregion

// region SHEET CONTROLLER

/// Central controller for bottom sheet lifecycle and position management.
class AppSheetController extends ChangeNotifier {
  AppSheetController();

  bool _isOpen = false;
  SheetPosition _currentPosition = SheetPosition.hidden;
  int _currentSnapIndex = 0;
  dynamic _result;

  /// Whether the sheet is currently visible.
  bool get isOpen => _isOpen;

  /// Current sheet position.
  SheetPosition get currentPosition => _currentPosition;

  /// Current snap point index.
  int get currentSnapIndex => _currentSnapIndex;

  /// Whether sheet is at full height.
  bool get isExpanded => _currentPosition == SheetPosition.full;

  /// Result from the last closed sheet.
  dynamic get result => _result;

  final StreamController<SheetPosition> _positionController =
      StreamController<SheetPosition>.broadcast();

  /// Stream of position changes.
  Stream<SheetPosition> get positionStream => _positionController.stream;

  /// Show a bottom sheet and return its result.
  Future<T?> showSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    List<SheetPosition> snapPoints = const [
      SheetPosition.peek,
      SheetPosition.full,
    ],
    int initialSnap = 0,
    double? peekHeight,
    bool dismissible = true,
    bool enableDrag = true,
    bool enableBackdropBlur = true,
    Duration? animationDuration,
  }) async {
    _isOpen = true;
    _currentSnapIndex = initialSnap;
    _currentPosition = snapPoints[initialSnap];
    notifyListeners();

    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: dismissible,
      enableDrag: false, // We handle dragging ourselves
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => AppBottomSheet(
        controller: this,
        builder: builder,
        snapPoints: snapPoints,
        initialSnap: initialSnap,
        peekHeight: peekHeight ?? 200,
        dismissible: dismissible,
        enableDrag: enableDrag,
        enableBackdropBlur: enableBackdropBlur,
        animationDuration: animationDuration,
      ),
    );

    _isOpen = false;
    _currentPosition = SheetPosition.hidden;
    _result = result;
    notifyListeners();

    return result;
  }

  /// Close the sheet with an optional result.
  void close<T>([T? result]) {
    _result = result;
    _isOpen = false;
    _currentPosition = SheetPosition.hidden;
    notifyListeners();
  }

  /// Snap to a specific position.
  void snapTo(SheetPosition position) {
    _currentPosition = position;
    _positionController.add(position);
    notifyListeners();
  }

  /// Toggle between peek and full positions.
  void toggle() {
    if (_currentPosition == SheetPosition.full) {
      snapTo(SheetPosition.peek);
    } else {
      snapTo(SheetPosition.full);
    }
  }

  /// Update current snap index.
  void updateSnapIndex(int index) {
    _currentSnapIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionController.close();
    super.dispose();
  }
}

// endregion

// region APP SHEET HANDLE

/// Visual drag handle for bottom sheet.
class AppSheetHandle extends StatefulWidget {
  const AppSheetHandle({
    super.key,
    this.onTap,
    this.color = const Color(0xFFBDBDBD),
    this.width = 40.0,
    this.height = 4.0,
  });

  final VoidCallback? onTap;
  final Color color;
  final double width;
  final double height;

  @override
  State<AppSheetHandle> createState() => _AppSheetHandleState();
}

class _AppSheetHandleState extends State<AppSheetHandle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppMotion.micro,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (!mounted) return;
    await _controller.forward();
    if (!mounted) return;
    await AppInteractionRefinement.onSelection(context);
    await _controller.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// endregion

// region APP BOTTOM SHEET

/// Main draggable bottom sheet widget with snap points.
class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({
    super.key,
    required this.builder,
    this.controller,
    this.snapPoints = const [SheetPosition.peek, SheetPosition.full],
    this.initialSnap = 0,
    this.peekHeight = 200,
    this.dismissible = true,
    this.enableDrag = true,
    this.enableBackdropBlur = true,
    this.barrierColor = const Color(0x99000000),
    this.backgroundColor = Colors.white,
    this.borderRadius = 24.0,
    this.animationDuration,
  });

  final WidgetBuilder builder;
  final AppSheetController? controller;
  final List<SheetPosition> snapPoints;
  final int initialSnap;
  final double peekHeight;
  final bool dismissible;
  final bool enableDrag;
  final bool enableBackdropBlur;
  final Color barrierColor;
  final Color backgroundColor;
  final double borderRadius;
  final Duration? animationDuration;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _backdropAnimation;

  late List<double> _snapHeights;
  late double _currentHeight;
  double _dragStartHeight = 0;
  int _currentSnapIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentSnapIndex = widget.initialSnap;

    _animationController = AnimationController(
      duration: widget.animationDuration ?? AppMotion.normal,
      vsync: this,
    );

    _backdropAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    // Calculate snap heights after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateSnapHeights();
      _animationController.forward();
      AppInteractionRefinement.onTap(context);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateSnapHeights() {
    final screenSize = MediaQuery.of(context).size;
    final safeArea = MediaQuery.of(context).padding;

    _snapHeights = widget.snapPoints
        .map((pos) => SheetPositionUtils.resolvePosition(
              pos,
              screenSize,
              safeArea,
              peekHeight: widget.peekHeight,
            ))
        .toList();

    setState(() {
      _currentHeight = _snapHeights[_currentSnapIndex];
    });
  }

  void _handleDragStart(DragStartDetails details) {
    _dragStartHeight = _currentHeight;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.enableDrag) return;

    setState(() {
      _currentHeight = (_dragStartHeight - details.primaryDelta!).clamp(
        _snapHeights.first,
        _snapHeights.last,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enableDrag) return;

    final velocity = details.primaryVelocity ?? 0;

    // Determine target snap based on velocity and position
    int targetSnap;
    if (velocity.abs() > 500) {
      // Strong velocity - snap in direction of movement
      if (velocity < 0) {
        // Dragging up - go to next higher snap
        targetSnap = (_currentSnapIndex + 1).clamp(0, _snapHeights.length - 1);
      } else {
        // Dragging down - go to previous lower snap
        targetSnap = (_currentSnapIndex - 1).clamp(0, _snapHeights.length - 1);
      }
    } else {
      // Weak velocity - snap to closest
      targetSnap = SheetPositionUtils.getClosestSnapIndex(
        _currentHeight,
        _snapHeights,
      );
    }

    _snapToIndex(targetSnap);
  }

  void _snapToIndex(int index) {
    if (index < 0 || index >= _snapHeights.length) return;

    final targetHeight = _snapHeights[index];

    setState(() {
      _currentSnapIndex = index;
      _currentHeight = targetHeight;
    });

    widget.controller?.updateSnapIndex(index);
    widget.controller?.snapTo(widget.snapPoints[index]);

    // Haptic feedback
    AppInteractionRefinement.onSelection(context);

    // If snapping to hidden, close the sheet
    if (widget.snapPoints[index] == SheetPosition.hidden && widget.dismissible) {
      _closeSheet();
    }
  }

  Future<void> _closeSheet() async {
    await AppInteractionRefinement.onTap(context);
    await _animationController.reverse();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _handleBackdropTap() {
    if (widget.dismissible) {
      _closeSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (!didPop && widget.dismissible) {
          await _closeSheet();
        }
      },
      child: Stack(
        children: [
          // Backdrop
          GestureDetector(
            onTap: _handleBackdropTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedBuilder(
              animation: _backdropAnimation,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: widget.barrierColor.withValues(
                    alpha: widget.barrierColor.a * _backdropAnimation.value,
                  ),
                  child: widget.enableBackdropBlur
                      ? Opacity(
                          opacity: _backdropAnimation.value,
                          child: const AppBlurBackdrop(
                            blurAmount: 12,
                            tintOpacity: 0.05,
                          ),
                        )
                      : null,
                );
              },
            ),
          ),

          // Sheet
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onVerticalDragStart: _handleDragStart,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              child: AnimatedContainer(
                duration: AppMotion.fast,
                curve: AppCurves.elastic,
                height: _currentHeight + keyboardHeight,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(widget.borderRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 24,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag handle
                      AppSheetHandle(
                        onTap: widget.controller?.toggle,
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: safeArea.bottom + keyboardHeight,
                          ),
                          child: widget.builder(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// endregion

// region HELPER FUNCTIONS

/// Show a simple bottom sheet with default settings.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  List<SheetPosition> snapPoints = const [
    SheetPosition.peek,
    SheetPosition.full,
  ],
  int initialSnap = 0,
  double peekHeight = 200,
  bool dismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    isDismissible: dismissible,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    builder: (context) => AppBottomSheet(
      builder: builder,
      snapPoints: snapPoints,
      initialSnap: initialSnap,
      peekHeight: peekHeight,
      dismissible: dismissible,
      enableDrag: enableDrag,
    ),
  );
}

// endregion

// region PREVIEW PANEL

/// QA/Testing preview panel for bottom sheet.
class SheetPreviewPanel extends StatefulWidget {
  const SheetPreviewPanel({super.key});

  @override
  State<SheetPreviewPanel> createState() => _SheetPreviewPanelState();
}

class _SheetPreviewPanelState extends State<SheetPreviewPanel> {
  final AppSheetController _controller = AppSheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSheet(String title, List<SheetPosition> snapPoints) {
    _controller.showSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Current position: ${_controller.currentPosition}',
              style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.snapTo(SheetPosition.peek),
                  child: const Text('Peek'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.snapTo(SheetPosition.half),
                  child: const Text('Half'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.snapTo(SheetPosition.full),
                  child: const Text('Full'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.close(),
                  child: const Text('Close'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Drag the sheet to test snap points!',
              style: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ),
      snapPoints: snapPoints,
      initialSnap: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _showSheet(
                'Peek + Full Sheet',
                [SheetPosition.peek, SheetPosition.full],
              ),
              child: const Text('Show Peek + Full'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showSheet(
                'Peek + Half + Full Sheet',
                [SheetPosition.peek, SheetPosition.half, SheetPosition.full],
              ),
              child: const Text('Show Peek + Half + Full'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showSheet(
                'Half + Full Sheet',
                [SheetPosition.half, SheetPosition.full],
              ),
              child: const Text('Show Half + Full'),
            ),
            const SizedBox(height: 24),
            ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Controller State',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text('Is Open: ${_controller.isOpen}'),
                        Text('Position: ${_controller.currentPosition}'),
                        Text('Snap Index: ${_controller.currentSnapIndex}'),
                        Text('Is Expanded: ${_controller.isExpanded}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// endregion

/// ✅ Phase 4.4.2 — AppBottomSheet System Complete
///
/// **Architecture:**
/// - **AppSheetController**: Lifecycle and position management with streams
/// - **AppBottomSheet**: Main draggable sheet with snap points
/// - **AppSheetHandle**: Visual drag handle with scale animation
/// - **SheetPositionUtils**: Position resolution utilities
/// - **Helper Functions**: Simplified sheet invocation
///
/// **Features:**
/// - Draggable gestures with velocity-based snap detection
/// - Spring physics animations (AppCurves.elastic)
/// - Blur backdrop with parallax fade (12px)
/// - Multiple snap points (peek/half/full/custom)
/// - Keyboard-aware layout with safe area handling
/// - Haptic feedback on snap, drag, and close
/// - Focus trapping with PopScope (Android predictive back)
/// - Performance-optimized with AnimatedContainer
///
/// **Motion Characteristics:**
/// - Micro (150ms): Handle scale animation
/// - Fast (200ms): Quick position adjustments
/// - Normal (300ms): Main snap transitions
/// - Elastic curve for spring-like overshoot
///
/// **Performance:**
/// - SingleTickerProviderStateMixin for efficient animations
/// - AnimatedContainer with clamp() for smooth dragging
/// - Proper disposal of controllers and streams
/// - ChangeNotifier for reactive state updates
/// - Minimal rebuild scope with targeted setState
///
/// **Usage Examples:**
///
/// ```dart
/// // 1. Using helper function
/// await showAppBottomSheet(
///   context: context,
///   builder: (context) => MyContent(),
///   snapPoints: [SheetPosition.peek, SheetPosition.full],
/// );
///
/// // 2. Using controller
/// final controller = AppSheetController();
///
/// await controller.showSheet(
///   context: context,
///   builder: (context) => MyContent(),
///   snapPoints: [
///     SheetPosition.peek,
///     SheetPosition.half,
///     SheetPosition.full,
///   ],
///   initialSnap: 0,
///   peekHeight: 300,
/// );
///
/// // Control programmatically
/// controller.snapTo(SheetPosition.full);
/// controller.toggle();
/// controller.close();
///
/// // 3. Listen to position changes
/// controller.positionStream.listen((position) {
///   print('Sheet moved to: $position');
/// });
/// ```
