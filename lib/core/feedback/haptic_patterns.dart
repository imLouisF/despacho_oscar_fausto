import 'haptic_feedback.dart';

/// 🎯 AppHapticPatterns - Contextual Haptic Feedback Layer
///
/// Provides semantic, user-friendly haptic feedback patterns that map user intent
/// to emotionally consistent tactile responses. Built on top of AppHaptics core layer.
///
/// **Design Philosophy:**
/// Each pattern communicates a specific emotional meaning through carefully chosen
/// vibration intensity and rhythm. This creates a consistent "haptic language" that
/// users learn to associate with specific UI outcomes.
///
/// **Pattern Categories:**
/// - **Affirmative**: Success, confirmation, completion
/// - **Cautionary**: Warning, attention, non-critical alert
/// - **Negative**: Error, rejection, failure
/// - **Informational**: Notification, update, message
/// - **Navigational**: Flow start, flow end, transition
///
/// **Integration:**
/// All patterns respect AppHaptics global enable/disable state and platform detection.
/// Duration and timing align with AppMotion constants for visual-tactile consistency.
///
/// Usage:
/// ```dart
/// // Success feedback after form submission
/// await AppHapticPatterns.success();
///
/// // Error feedback on validation failure
/// await AppHapticPatterns.error();
///
/// // Navigation start on screen transition
/// await AppHapticPatterns.navigationStart();
/// ```

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// === AppHapticPatterns: Contextual Feedback Layer ===
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Semantic haptic feedback patterns for context-aware user interactions.
///
/// Provides high-level haptic patterns that map to specific UX scenarios,
/// creating a consistent emotional feedback language throughout the app.
class AppHapticPatterns {
  AppHapticPatterns._();

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Configuration                                                   │
  // └─────────────────────────────────────────────────────────────────┘

  /// Global flag to enable/disable contextual haptic patterns.
  /// When disabled, all pattern methods become no-ops.
  /// Respects AppHaptics.isEnabled as the master switch.
  static bool _isPatternsEnabled = true;

  /// Returns true if contextual patterns are enabled.
  /// Note: Also requires AppHaptics.isEnabled to be true.
  static bool get isEnabled =>
      _isPatternsEnabled && AppHaptics.isEnabled;

  /// Enable contextual haptic patterns.
  static void enable() => _isPatternsEnabled = true;

  /// Disable contextual haptic patterns.
  static void disable() => _isPatternsEnabled = false;

  /// Toggle contextual patterns on/off.
  static void toggle() => _isPatternsEnabled = !_isPatternsEnabled;

  /// Check if patterns should execute (respects both local and global flags).
  static bool get _shouldExecute => isEnabled;

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Affirmative Patterns (Success, Confirmation)                    │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a success feedback pattern.
  ///
  /// **Emotional Meaning:** Affirmation, completion, positive outcome
  ///
  /// **UX Scenarios:**
  /// - Form submission successful
  /// - Payment processed
  /// - File upload complete
  /// - Task marked as done
  /// - Settings saved successfully
  ///
  /// **Pattern:** Two light impacts with 150ms delay (total ~300ms)
  /// **Duration:** Matches AppMotion.normal (300ms)
  /// **Feeling:** Gentle, celebratory "✓ Done" confirmation
  ///
  /// **Platform Behavior:**
  /// - Mobile: Double light tap sensation
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // After successful form submission
  /// if (response.success) {
  ///   await AppHapticPatterns.success();
  ///   Navigator.pop(context);
  /// }
  /// ```
  static Future<void> success() async {
    if (!_shouldExecute) return;

    try {
      // First pulse: immediate confirmation
      await AppHaptics.lightImpact();

      // Brief pause for rhythm (AppMotion.micro = 150ms)
      await Future.delayed(const Duration(milliseconds: 150));

      // Second pulse: completion celebration
      await AppHaptics.lightImpact();
    } catch (_) {
      // Silent failure - patterns should never crash the app
    }
  }

  /// Triggers a confirmation feedback pattern.
  ///
  /// **Emotional Meaning:** Acknowledgment, acceptance, "got it"
  ///
  /// **UX Scenarios:**
  /// - Checkbox checked
  /// - Item added to cart
  /// - Bookmark saved
  /// - Preference toggled
  /// - Quick action confirmed
  ///
  /// **Pattern:** Single medium impact
  /// **Duration:** Matches AppMotion.fast (200ms)
  /// **Feeling:** Solid, reassuring click
  ///
  /// Example:
  /// ```dart
  /// // On checkbox toggle
  /// setState(() => isChecked = !isChecked);
  /// await AppHapticPatterns.confirmation();
  /// ```
  static Future<void> confirmation() async {
    if (!_shouldExecute) return;
    await AppHaptics.mediumImpact();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Cautionary Patterns (Warning, Attention)                        │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a warning feedback pattern.
  ///
  /// **Emotional Meaning:** Caution, attention needed, proceed carefully
  ///
  /// **UX Scenarios:**
  /// - Form validation warning (non-blocking)
  /// - Low battery notification
  /// - Unsaved changes alert
  /// - Approaching limit (storage, quota)
  /// - Suspicious activity detection
  ///
  /// **Pattern:** Single medium impact
  /// **Duration:** Matches AppMotion.fast (200ms)
  /// **Feeling:** Noticeable but not aggressive, "heads up"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Moderate tap, less than error
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // On form validation warning
  /// if (hasWarnings) {
  ///   await AppHapticPatterns.warning();
  ///   showWarningSnackBar(context, warnings);
  /// }
  /// ```
  static Future<void> warning() async {
    if (!_shouldExecute) return;
    await AppHaptics.mediumImpact();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Negative Patterns (Error, Rejection)                            │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers an error feedback pattern.
  ///
  /// **Emotional Meaning:** Alert, rejection, failure, something went wrong
  ///
  /// **UX Scenarios:**
  /// - Form submission failed
  /// - Invalid input detected
  /// - Network error occurred
  /// - Permission denied
  /// - Action cannot be completed
  /// - Deletion prevented (constraint)
  ///
  /// **Pattern:** Single heavy impact
  /// **Duration:** Matches AppMotion.normal (300ms)
  /// **Feeling:** Strong, emphatic "NO" or "STOP"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Firm, noticeable vibration
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // On form submission error
  /// try {
  ///   await submitForm(data);
  ///   await AppHapticPatterns.success();
  /// } catch (e) {
  ///   await AppHapticPatterns.error();
  ///   showErrorDialog(context, e.message);
  /// }
  /// ```
  static Future<void> error() async {
    if (!_shouldExecute) return;
    await AppHaptics.heavyImpact();
  }

  /// Triggers a deletion feedback pattern.
  ///
  /// **Emotional Meaning:** Destructive action, permanent removal
  ///
  /// **UX Scenarios:**
  /// - Item deleted from list
  /// - Account removed
  /// - File permanently deleted
  /// - Conversation archived
  ///
  /// **Pattern:** Heavy impact (same as error, but semantically different)
  /// **Duration:** Matches AppMotion.normal (300ms)
  /// **Feeling:** Emphatic, final, "it's gone"
  ///
  /// Example:
  /// ```dart
  /// // After delete confirmation
  /// await deleteItem(itemId);
  /// await AppHapticPatterns.deletion();
  /// Navigator.pop(context);
  /// ```
  static Future<void> deletion() async {
    if (!_shouldExecute) return;
    await AppHaptics.heavyImpact();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Informational Patterns (Notification, Update)                   │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a notification feedback pattern.
  ///
  /// **Emotional Meaning:** Information available, update, gentle ping
  ///
  /// **UX Scenarios:**
  /// - New message received
  /// - Background task completed
  /// - Status update available
  /// - Timer/reminder triggered
  /// - Badge count changed
  ///
  /// **Pattern:** Single selection click
  /// **Duration:** Matches AppMotion.micro (150ms)
  /// **Feeling:** Crisp, subtle "ping" or "ding"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Sharp, brief tick
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // On new message received
  /// void onMessageReceived(Message msg) {
  ///   setState(() => messages.add(msg));
  ///   AppHapticPatterns.notification();
  /// }
  /// ```
  static Future<void> notification() async {
    if (!_shouldExecute) return;
    await AppHaptics.selectionClick();
  }

  /// Triggers an impact feedback pattern for general interactions.
  ///
  /// **Emotional Meaning:** Neutral acknowledgment, generic interaction
  ///
  /// **UX Scenarios:**
  /// - Generic button tap
  /// - List item selected
  /// - Tab switched
  /// - Menu item clicked
  ///
  /// **Pattern:** Single medium impact
  /// **Duration:** Matches AppMotion.fast (200ms)
  /// **Feeling:** Neutral, standard tap response
  ///
  /// Example:
  /// ```dart
  /// // On generic button press
  /// onPressed: () async {
  ///   await AppHapticPatterns.impact();
  ///   handleAction();
  /// }
  /// ```
  static Future<void> impact() async {
    if (!_shouldExecute) return;
    await AppHaptics.mediumImpact();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Navigational Patterns (Flow Start, Flow End)                    │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a navigation start feedback pattern.
  ///
  /// **Emotional Meaning:** Beginning a flow, initiating transition
  ///
  /// **UX Scenarios:**
  /// - Screen push (forward navigation)
  /// - Modal opens
  /// - Drawer opens
  /// - Bottom sheet appears
  /// - Expanding panel
  ///
  /// **Pattern:** Single light impact
  /// **Duration:** Matches AppMotion.micro (150ms)
  /// **Feeling:** Gentle, anticipatory "here we go"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Subtle tap on transition start
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // On screen navigation
  /// onTap: () async {
  ///   await AppHapticPatterns.navigationStart();
  ///   Navigator.push(context, MaterialPageRoute(
  ///     builder: (_) => DetailScreen(),
  ///   ));
  /// }
  /// ```
  static Future<void> navigationStart() async {
    if (!_shouldExecute) return;
    await AppHaptics.lightImpact();
  }

  /// Triggers a navigation end feedback pattern.
  ///
  /// **Emotional Meaning:** Completing a flow, arriving at destination
  ///
  /// **UX Scenarios:**
  /// - Screen pop (back navigation)
  /// - Modal closes
  /// - Drawer closes
  /// - Bottom sheet dismisses
  /// - Collapsing panel
  ///
  /// **Pattern:** Single medium impact
  /// **Duration:** Matches AppMotion.fast (200ms)
  /// **Feeling:** Solid, "we've arrived"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Moderate tap on transition end
  /// - Desktop/Web: No haptic (silent)
  ///
  /// Example:
  /// ```dart
  /// // On back navigation
  /// onPressed: () async {
  ///   await AppHapticPatterns.navigationEnd();
  ///   Navigator.pop(context);
  /// }
  /// ```
  static Future<void> navigationEnd() async {
    if (!_shouldExecute) return;
    await AppHaptics.mediumImpact();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Selection Patterns (Picker, Toggle, Choice)                     │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a selection feedback pattern.
  ///
  /// **Emotional Meaning:** Discrete choice made, option selected
  ///
  /// **UX Scenarios:**
  /// - Picker wheel scrolled
  /// - Segmented control switched
  /// - Radio button selected
  /// - Dropdown item chosen
  /// - Slider value changed
  ///
  /// **Pattern:** Single selection click
  /// **Duration:** Matches AppMotion.micro (150ms)
  /// **Feeling:** Crisp, mechanical "click"
  ///
  /// **Platform Behavior:**
  /// - Mobile: Sharp tick per selection change
  /// - Desktop/Web: No haptic (silent)
  ///
  /// **Note:** For continuous scrolling (like pickers), call on discrete steps,
  /// not on every frame to avoid haptic overload.
  ///
  /// Example:
  /// ```dart
  /// // On picker value change
  /// CupertinoPicker(
  ///   onSelectedItemChanged: (index) {
  ///     AppHapticPatterns.selection();
  ///     setState(() => selectedIndex = index);
  ///   },
  ///   // ...
  /// )
  /// ```
  static Future<void> selection() async {
    if (!_shouldExecute) return;
    await AppHaptics.selectionClick();
  }

  // ┌─────────────────────────────────────────────────────────────────┐
  // │ Complex Patterns (Combining Multiple Haptics)                   │
  // └─────────────────────────────────────────────────────────────────┘

  /// Triggers a long press feedback pattern.
  ///
  /// **Emotional Meaning:** Extended interaction recognized, alternate action
  ///
  /// **UX Scenarios:**
  /// - Long press menu triggered
  /// - Context menu opened
  /// - Drag-and-drop initiated
  /// - Alternative action activated
  ///
  /// **Pattern:** Heavy impact (indicates mode change)
  /// **Duration:** Matches AppMotion.normal (300ms)
  /// **Feeling:** Firm, "you've entered a different mode"
  ///
  /// Example:
  /// ```dart
  /// // On long press gesture
  /// GestureDetector(
  ///   onLongPress: () async {
  ///     await AppHapticPatterns.longPress();
  ///     showContextMenu(context);
  ///   },
  ///   // ...
  /// )
  /// ```
  static Future<void> longPress() async {
    if (!_shouldExecute) return;
    await AppHaptics.heavyImpact();
  }

  /// Triggers a boundary feedback pattern.
  ///
  /// **Emotional Meaning:** Limit reached, can't go further
  ///
  /// **UX Scenarios:**
  /// - Scrolled to top/bottom (overscroll)
  /// - Max input length reached
  /// - Volume at max/min
  /// - Zoom limit reached
  ///
  /// **Pattern:** Medium impact (gentle resistance)
  /// **Duration:** Matches AppMotion.fast (200ms)
  /// **Feeling:** Soft "bump" against a wall
  ///
  /// Example:
  /// ```dart
  /// // On scroll boundary
  /// if (scrollController.position.atEdge) {
  ///   AppHapticPatterns.boundary();
  /// }
  /// ```
  static Future<void> boundary() async {
    if (!_shouldExecute) return;
    await AppHaptics.mediumImpact();
  }
}
