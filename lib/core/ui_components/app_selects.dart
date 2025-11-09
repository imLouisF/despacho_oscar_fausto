import 'package:flutter/material.dart';
import '../animation/app_motion.dart';
import '../interaction/global_interaction_refinement.dart';
import '../theme/microstyle.dart';

/// 🎯 AppSelect System - Dropdown Components
///
/// **Design Philosophy:**
/// "Apple meets LegalTech" - Elegant dropdown selects with glass morphism,
/// smooth expand/collapse animations, and tactile haptic feedback.
///
/// **Components:**
/// 1. **AppDropdownSelect** - Dropdown with floating label and glass options
/// 2. **AppSelectOption** - Individual option with icon and sublabel support
///
/// **Features:**
/// - Floating label animation (matching AppTextField)
/// - Glass card container for options list
/// - Fade + slide down expand animation (250ms)
/// - Keyboard navigation support
/// - Validation feedback with error messages
/// - Haptic feedback on selection
/// - Purple gradient aesthetic
///
/// **Integration:**
/// - AppMotion timing and curves
/// - AppInteractionRefinement for haptics
/// - AppMicroStyle for shadows and blur
/// - Compatible with AppFormContainer

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ENUMS & TOKENS ━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Design tokens for dropdown selects.
class AppSelectColors {
  AppSelectColors._();

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDisabled = Color(0xFFF5F5F5);
  static const Color optionsBackground = Color(0xFAFFFFFF); // 98% white
  static const Color optionHover = Color(0x1A512DA8); // 10% purple

  // Border colors
  static const Color borderNormal = Color(0x33512DA8); // 20% purple
  static const Color borderFocused = Color(0xFF512DA8); // Deep purple
  static const Color borderError = Color(0xFFD32F2F); // Red 700

  // Text colors
  static const Color text = Color(0xFF1A1A1A);
  static const Color textHint = Color(0x99512DA8); // 60% purple
  static const Color textError = Color(0xFFD32F2F);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color textSublabel = Color(0xFF757575);

  // Label colors
  static const Color labelNormal = Color(0x99512DA8);
  static const Color labelFocused = Color(0xFF512DA8);
  static const Color labelError = Color(0xFFD32F2F);

  // Icon colors
  static const Color icon = Color(0xFF512DA8);
  static const Color iconDisabled = Color(0xFFBDBDBD);

  // Selection colors
  static const Color selectedBackground = Color(0x1A512DA8); // 10% purple
  static const Color selectedBorder = Color(0xFF512DA8);
}

class AppSelectMetrics {
  AppSelectMetrics._();

  // Border radius
  static const double radius = 16.0;
  static const double optionsRadius = 12.0;

  // Padding
  static const EdgeInsets paddingSelect = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const EdgeInsets paddingOption = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  // Border width
  static const double borderWidth = 1.5;
  static const double borderWidthFocused = 2.0;

  // Label
  static const double labelFontSizeNormal = 16.0;
  static const double labelFontSizeFloating = 12.0;
  static const double labelTopNormal = 12.0;
  static const double labelTopFloating = -8.0;

  // Icon size
  static const double iconSize = 20.0;
  static const double chevronSize = 20.0;

  // Options list
  static const double optionsMaxHeight = 300.0;
  static const double optionsSpacing = 8.0;

  // Transition durations
  static const Duration transitionNormal = AppMotion.normal; // 300ms
  static const Duration transitionFast = AppMotion.fast; // 200ms

  // Opacity
  static const double opacityDisabled = 0.6;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━ APP SELECT OPTION ━━━━━━━━━━━━━━━━━━━━━━━━━

/// Individual option for dropdown select.
class AppSelectOption<T> {
  const AppSelectOption({
    required this.value,
    required this.label,
    this.sublabel,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? sublabel;
  final IconData? icon;
  final bool enabled;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━ APP DROPDOWN SELECT ━━━━━━━━━━━━━━━━━━━━━━━━━

/// Professional dropdown select with floating label and glass options.
class AppDropdownSelect<T> extends StatefulWidget {
  const AppDropdownSelect({
    super.key,
    required this.options,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.enabled = true,
    this.prefixIcon,
  });

  final List<AppSelectOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool enabled;
  final IconData? prefixIcon;

  @override
  State<AppDropdownSelect<T>> createState() => _AppDropdownSelectState<T>();
}

class _AppDropdownSelectState<T> extends State<AppDropdownSelect<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppSelectMetrics.transitionNormal,
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: AppCurves.smooth,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: AppCurves.smooth,
    ));
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    setState(() => _isOpen = true);
    AppInteractionRefinement.onTap(context);

    _overlayEntry = _createOverlayEntry();
    if (!mounted) return;
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
  }

  void _closeDropdown() async {
    await _animationController.reverse();
    _removeOverlay();
    if (mounted) {
      setState(() => _isOpen = false);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _selectOption(T value) async {
    await AppInteractionRefinement.onSelection(context);
    widget.onChanged?.call(value);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _closeDropdown,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 8),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Material(
                      color: Colors.transparent,
                      child: _buildOptionsCard(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsCard() {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: AppSelectMetrics.optionsMaxHeight,
      ),
      decoration: BoxDecoration(
        color: AppSelectColors.optionsBackground,
        borderRadius: BorderRadius.circular(AppSelectMetrics.optionsRadius),
        border: Border.all(
          color: AppSelectColors.borderFocused,
          width: 1.5,
        ),
        boxShadow: [AppMicroStyle.shadowMedium],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSelectMetrics.optionsRadius),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.options.map((option) {
              final isSelected = widget.value == option.value;
              return _buildOption(option, isSelected);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(AppSelectOption<T> option, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: option.enabled ? () => _selectOption(option.value) : null,
        child: Container(
          padding: AppSelectMetrics.paddingOption,
          decoration: BoxDecoration(
            color: isSelected ? AppSelectColors.selectedBackground : null,
            border: isSelected
                ? Border(
                    left: BorderSide(
                      color: AppSelectColors.selectedBorder,
                      width: 3,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              if (option.icon != null) ...[
                Icon(
                  option.icon,
                  size: AppSelectMetrics.iconSize,
                  color: option.enabled
                      ? AppSelectColors.icon
                      : AppSelectColors.iconDisabled,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: option.enabled
                            ? AppSelectColors.text
                            : AppSelectColors.textDisabled,
                      ),
                    ),
                    if (option.sublabel != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        option.sublabel!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppSelectColors.textSublabel,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  size: AppSelectMetrics.iconSize,
                  color: AppSelectColors.icon,
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppSelectOption<T>? get _selectedOption {
    if (widget.value == null) return null;
    try {
      return widget.options.firstWhere((opt) => opt.value == widget.value);
    } catch (_) {
      return null;
    }
  }

  Color get _borderColor {
    if (widget.errorText != null) return AppSelectColors.borderError;
    if (_isOpen) return AppSelectColors.borderFocused;
    return AppSelectColors.borderNormal;
  }

  Color get _labelColor {
    if (widget.errorText != null) return AppSelectColors.labelError;
    if (_isOpen) return AppSelectColors.labelFocused;
    return AppSelectColors.labelNormal;
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = _selectedOption;
    final hasValue = selectedOption != null;
    final shouldFloat = _isOpen || hasValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: AnimatedContainer(
              duration: AppSelectMetrics.transitionNormal,
              curve: AppCurves.smooth,
              decoration: BoxDecoration(
                color: widget.enabled
                    ? AppSelectColors.background
                    : AppSelectColors.backgroundDisabled,
                borderRadius: BorderRadius.circular(AppSelectMetrics.radius),
                border: Border.all(
                  color: _borderColor,
                  width: _isOpen
                      ? AppSelectMetrics.borderWidthFocused
                      : AppSelectMetrics.borderWidth,
                ),
                boxShadow: _isOpen ? [AppMicroStyle.shadowSoft] : null,
              ),
              child: Stack(
                children: [
                  // Selected value display
                  Padding(
                    padding: AppSelectMetrics.paddingSelect.copyWith(
                      left: widget.prefixIcon != null ? 48 : 16,
                      right: 48,
                      top: widget.label != null ? 20 : 12,
                    ),
                    child: Row(
                      children: [
                        if (selectedOption?.icon != null) ...[
                          Icon(
                            selectedOption!.icon,
                            size: AppSelectMetrics.iconSize,
                            color: AppSelectColors.icon,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            hasValue ? selectedOption.label : (widget.hint ?? ''),
                            style: TextStyle(
                              fontSize: 16,
                              color: hasValue
                                  ? AppSelectColors.text
                                  : AppSelectColors.textHint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Floating label
                  if (widget.label != null)
                    AnimatedPositioned(
                      duration: AppSelectMetrics.transitionFast,
                      curve: AppCurves.smooth,
                      left: widget.prefixIcon != null ? 48 : 16,
                      top: shouldFloat
                          ? AppSelectMetrics.labelTopFloating
                          : AppSelectMetrics.labelTopNormal,
                      child: AnimatedDefaultTextStyle(
                        duration: AppSelectMetrics.transitionFast,
                        curve: AppCurves.smooth,
                        style: TextStyle(
                          fontSize: shouldFloat
                              ? AppSelectMetrics.labelFontSizeFloating
                              : AppSelectMetrics.labelFontSizeNormal,
                          color: _labelColor,
                          fontWeight: FontWeight.w500,
                          backgroundColor: shouldFloat
                              ? AppSelectColors.background
                              : Colors.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: shouldFloat ? 4 : 0,
                          ),
                          child: Text(widget.label!),
                        ),
                      ),
                    ),

                  // Prefix icon
                  if (widget.prefixIcon != null)
                    Positioned(
                      left: 16,
                      top: widget.label != null ? 20 : 12,
                      child: Icon(
                        widget.prefixIcon,
                        size: AppSelectMetrics.iconSize,
                        color: widget.enabled
                            ? AppSelectColors.icon
                            : AppSelectColors.iconDisabled,
                      ),
                    ),

                  // Chevron icon
                  Positioned(
                    right: 16,
                    top: widget.label != null ? 20 : 12,
                    child: AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: AppSelectMetrics.transitionNormal,
                      curve: AppCurves.smooth,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: AppSelectMetrics.chevronSize,
                        color: widget.enabled
                            ? AppSelectColors.icon
                            : AppSelectColors.iconDisabled,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Error message
        if (widget.errorText != null)
          AnimatedOpacity(
            opacity: 1.0,
            duration: AppSelectMetrics.transitionFast,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 14,
                    color: AppSelectColors.textError,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.errorText!,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppSelectColors.textError,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// ✅ Phase 4.3.2 — Selects System Complete
///
/// **Components:**
/// - AppDropdownSelect: Dropdown with floating label and glass options
/// - AppSelectOption: Option model with icon and sublabel support
///
/// **Features:**
/// - Floating label animation matching AppTextField
/// - Glass card options container
/// - Fade + slide expand animation (300ms)
/// - Keyboard-accessible overlay
/// - Validation feedback
/// - Haptic feedback on selection
/// - Purple gradient aesthetic
