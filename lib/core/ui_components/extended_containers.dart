import 'package:flutter/material.dart';
import '../animation/app_motion.dart';
import 'app_cards.dart';

/// 🎯 Extended Containers System - Layout-Specific Container Components
///
/// **Design Philosophy:**
/// Builds upon the AppCard foundation to provide specialized layout containers
/// that handle common UI patterns with consistent motion, spacing, and interaction.
/// Maintains "Apple meets LegalTech" aesthetic with Deep Purple Jurídico palette.
///
/// **Container Types:**
/// 1. **AppListContainer** - Scrollable list with adaptive padding and staggered animations
/// 2. **AppFormContainer** - Glass-based form wrapper with validation state support
/// 3. **AppCardGrid** - Responsive grid layout with automatic spacing
/// 4. **AppSectionDivider** - Elegant separator with gradient or blur effects
///
/// **Integration:**
/// - Uses AppCard, AppGlassCard, AppGradientCard as building blocks
/// - AppMotion for entry animations and transitions
/// - AppInteractionRefinement for consistent feedback
/// - AppCardMetrics for spacing and sizing consistency
///
/// **Usage:**
/// ```dart
/// // Scrollable list of cases
/// AppListContainer(
///   title: 'Casos Activos',
///   children: cases.map((c) => AppCard(
///     child: ListTile(title: Text(c.name)),
///   )).toList(),
/// )
///
/// // Form with validation
/// AppFormContainer(
///   title: 'Nuevo Caso',
///   children: [
///     TextField(decoration: InputDecoration(labelText: 'Título')),
///     TextField(decoration: InputDecoration(labelText: 'Descripción')),
///   ],
/// )
///
/// // Responsive grid
/// AppCardGrid(
///   children: [
///     InfoCard(title: 'Total', value: '42'),
///     InfoCard(title: 'Activos', value: '15'),
///   ],
/// )
/// ```

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Scrollable container for structured lists with staggered entry animations.
///
/// Perfect for displaying lists of cards, items, or any vertically stacked content.
/// Includes optional header, adaptive padding, and smooth entry animations.
///
/// **Features:**
/// - Automatic staggered fade-in animations for children
/// - Optional header with title and action button
/// - Adaptive padding based on screen size
/// - Smooth scroll physics with iOS-style bounce
/// - Supports pull-to-refresh pattern
///
/// **Best Use Cases:**
/// - Case lists, document lists, activity feeds
/// - Search results, filtered content
/// - Scrollable dashboards or sections
///
/// **Example:**
/// ```dart
/// AppListContainer(
///   title: 'Casos Recientes',
///   actionLabel: 'Ver Todos',
///   onAction: () => navigateToAllCases(),
///   children: [
///     AppCard(child: ListTile(title: Text('Caso #1'))),
///     AppCard(child: ListTile(title: Text('Caso #2'))),
///     AppCard(child: ListTile(title: Text('Caso #3'))),
///   ],
/// )
/// ```
class AppListContainer extends StatelessWidget {
  const AppListContainer({
    super.key,
    required this.children,
    this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.padding,
    this.enableStaggeredAnimation = true,
    this.scrollable = true,
    this.showDividers = false,
  });

  /// List of widgets to display (typically AppCard instances).
  final List<Widget> children;

  /// Optional header title.
  final String? title;

  /// Optional header subtitle.
  final String? subtitle;

  /// Optional action button label in header.
  final String? actionLabel;

  /// Callback for action button.
  final VoidCallback? onAction;

  /// Custom padding (overrides adaptive default).
  final EdgeInsetsGeometry? padding;

  /// Whether to enable staggered fade-in animations.
  final bool enableStaggeredAnimation;

  /// Whether the list should be scrollable.
  final bool scrollable;

  /// Whether to show dividers between items.
  final bool showDividers;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 600 ? 24 : 16,
          vertical: 16,
        );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section
        if (title != null) ...[
          Padding(
            padding: effectivePadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppCardColors.gradientStart,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (actionLabel != null && onAction != null)
                  TextButton(
                    onPressed: onAction,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(actionLabel!),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],

        // List items
        ...List.generate(children.length, (index) {
          final child = children[index];
          final isLast = index == children.length - 1;

          return enableStaggeredAnimation
              ? _StaggeredAnimationWrapper(
                  index: index,
                  child: Column(
                    children: [
                      child,
                      if (showDividers && !isLast)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: effectivePadding.horizontal / 2,
                          ),
                          child: const Divider(height: 1),
                        ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    child,
                    if (showDividers && !isLast)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: effectivePadding.horizontal / 2,
                        ),
                        child: const Divider(height: 1),
                      ),
                  ],
                );
        }),
      ],
    );

    return scrollable
        ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: content,
          )
        : content;
  }
}

/// Glassmorphism-based container optimized for forms with validation states.
///
/// Provides a beautiful frosted glass background perfect for input forms,
/// with support for validation states, error messages, and action buttons.
///
/// **Features:**
/// - Automatic glass blur effect with purple tint
/// - Built-in title, description, and footer support
/// - Validation state visual feedback
/// - Smooth focus and error state transitions
/// - Responsive padding and layout
///
/// **Best Use Cases:**
/// - Data entry forms, case creation, document upload
/// - Settings panels, profile editors
/// - Modal forms, dialog content
///
/// **Example:**
/// ```dart
/// AppFormContainer(
///   title: 'Crear Nuevo Caso',
///   description: 'Ingresa los datos del expediente legal',
///   isValid: _formKey.currentState?.validate() ?? false,
///   errorMessage: _errorMessage,
///   children: [
///     TextField(decoration: InputDecoration(labelText: 'Título')),
///     SizedBox(height: 16),
///     TextField(decoration: InputDecoration(labelText: 'Cliente')),
///     SizedBox(height: 16),
///     DropdownButton(items: [...]),
///   ],
///   actions: [
///     AppButton.secondary(label: 'Cancelar', onPressed: () {}),
///     AppButton.primary(label: 'Guardar', onPressed: () {}),
///   ],
/// )
/// ```
class AppFormContainer extends StatelessWidget {
  const AppFormContainer({
    super.key,
    required this.children,
    this.title,
    this.description,
    this.actions,
    this.isValid = true,
    this.errorMessage,
    this.padding,
    this.margin,
    this.useGlassEffect = true,
  });

  /// Form fields and content widgets.
  final List<Widget> children;

  /// Optional form title.
  final String? title;

  /// Optional form description/helper text.
  final String? description;

  /// Optional action buttons (typically submit and cancel).
  final List<Widget>? actions;

  /// Whether the form is in a valid state.
  final bool isValid;

  /// Optional error message to display.
  final String? errorMessage;

  /// Custom padding (overrides default).
  final EdgeInsetsGeometry? padding;

  /// Custom margin (overrides default).
  final EdgeInsetsGeometry? margin;

  /// Whether to use glass effect or standard card.
  final bool useGlassEffect;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? AppCardMetrics.paddingLarge;
    final effectiveMargin = margin ?? AppCardMetrics.marginMedium;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppCardColors.gradientStart,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],

        // Form fields
        ...children,

        // Error message
        if (!isValid && errorMessage != null) ...[
          const SizedBox(height: 16),
          AnimatedOpacity(
            opacity: !isValid ? 1.0 : 0.0,
            duration: AppMotion.fast,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

        // Actions
        if (actions != null && actions!.isNotEmpty) ...[
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              actions!.length,
              (index) => Padding(
                padding: EdgeInsets.only(left: index > 0 ? 12 : 0),
                child: actions![index],
              ),
            ),
          ),
        ],
      ],
    );

    if (useGlassEffect) {
      return AppGlassCard(
        padding: effectivePadding,
        margin: effectiveMargin,
        child: content,
      );
    } else {
      return AppCard(
        padding: effectivePadding,
        margin: effectiveMargin,
        child: content,
      );
    }
  }
}

/// Responsive grid layout container for cards with automatic spacing.
///
/// Automatically arranges cards in a grid with responsive column counts
/// based on screen size, maintaining consistent spacing and alignment.
///
/// **Features:**
/// - Responsive column count (1-4 columns based on width)
/// - Automatic spacing and padding
/// - Supports any card type (InfoCard, ActionCard, AppCard)
/// - Staggered entry animations
/// - Maintains aspect ratio option
///
/// **Best Use Cases:**
/// - Dashboard statistics grids
/// - Feature cards, service offerings
/// - Image galleries, document thumbnails
/// - Quick action panels
///
/// **Example:**
/// ```dart
/// AppCardGrid(
///   crossAxisCount: 2,
///   children: [
///     InfoCard(title: 'Casos', value: '42', icon: Icons.folder),
///     InfoCard(title: 'Documentos', value: '128', icon: Icons.description),
///     InfoCard(title: 'Clientes', value: '35', icon: Icons.people),
///     InfoCard(title: 'Audiencias', value: '12', icon: Icons.gavel),
///   ],
/// )
/// ```
class AppCardGrid extends StatelessWidget {
  const AppCardGrid({
    super.key,
    required this.children,
    this.crossAxisCount,
    this.childAspectRatio = 1.0,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.padding,
    this.enableStaggeredAnimation = true,
  });

  /// Grid item widgets (typically InfoCard or ActionCard).
  final List<Widget> children;

  /// Number of columns (null = responsive auto).
  final int? crossAxisCount;

  /// Width to height ratio for grid items.
  final double childAspectRatio;

  /// Vertical spacing between items.
  final double? mainAxisSpacing;

  /// Horizontal spacing between items.
  final double? crossAxisSpacing;

  /// Container padding.
  final EdgeInsetsGeometry? padding;

  /// Whether to enable staggered animations.
  final bool enableStaggeredAnimation;

  /// Determines responsive column count based on screen width.
  int _getResponsiveColumnCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveCrossAxisCount =
        crossAxisCount ?? _getResponsiveColumnCount(screenWidth);
    final effectivePadding = padding ?? AppCardMetrics.paddingMedium;
    final effectiveMainAxisSpacing = mainAxisSpacing ?? 16.0;
    final effectiveCrossAxisSpacing = crossAxisSpacing ?? 16.0;

    return Padding(
      padding: effectivePadding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: effectiveCrossAxisCount,
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: effectiveMainAxisSpacing,
          crossAxisSpacing: effectiveCrossAxisSpacing,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];
          return enableStaggeredAnimation
              ? _StaggeredAnimationWrapper(
                  index: index,
                  child: child,
                )
              : child;
        },
      ),
    );
  }
}

/// Elegant section divider with gradient or blur effects.
///
/// Creates visual separation between content sections with smooth animations
/// and optional label text. Supports gradient line, blur line, or simple divider.
///
/// **Features:**
/// - Multiple visual styles (gradient, blur, simple)
/// - Optional center label with background
/// - Fade-in animation
/// - Customizable thickness, spacing, and colors
/// - Responsive padding
///
/// **Best Use Cases:**
/// - Separating dashboard sections
/// - Content category dividers
/// - Form section breaks
/// - Timeline markers
///
/// **Example:**
/// ```dart
/// // Gradient divider with label
/// AppSectionDivider(
///   label: 'Estadísticas del Mes',
///   type: DividerType.gradient,
/// )
///
/// // Simple thin divider
/// AppSectionDivider(
///   type: DividerType.simple,
///   thickness: 1,
/// )
///
/// // Blur effect divider
/// AppSectionDivider(
///   type: DividerType.blur,
///   label: 'Casos Recientes',
/// )
/// ```
class AppSectionDivider extends StatefulWidget {
  const AppSectionDivider({
    super.key,
    this.label,
    this.type = DividerType.gradient,
    this.thickness = 2.0,
    this.spacing = 24.0,
    this.animated = true,
  });

  /// Optional label text to display in center.
  final String? label;

  /// Visual style of the divider.
  final DividerType type;

  /// Line thickness.
  final double thickness;

  /// Vertical spacing around divider.
  final double spacing;

  /// Whether to animate the divider on mount.
  final bool animated;

  @override
  State<AppSectionDivider> createState() => _AppSectionDividerState();
}

class _AppSectionDividerState extends State<AppSectionDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.normal,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AppCurves.gentle,
    );

    if (widget.animated) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.spacing),
        child: widget.label != null
            ? _buildDividerWithLabel()
            : _buildSimpleDivider(),
      ),
    );
  }

  Widget _buildDividerWithLabel() {
    return Row(
      children: [
        Expanded(child: _buildDividerLine()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppCardColors.surfaceTinted,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppCardColors.borderHighlight.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppCardColors.gradientStart,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Expanded(child: _buildDividerLine()),
      ],
    );
  }

  Widget _buildSimpleDivider() {
    return _buildDividerLine();
  }

  Widget _buildDividerLine() {
    switch (widget.type) {
      case DividerType.gradient:
        return Container(
          height: widget.thickness,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppCardColors.gradientStart.withValues(alpha: 0.3),
                AppCardColors.gradientEnd.withValues(alpha: 0.3),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
        );

      case DividerType.blur:
        return Container(
          height: widget.thickness,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppCardColors.borderHighlight.withValues(alpha: 0.4),
                Colors.transparent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppCardColors.gradientStart.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        );

      case DividerType.simple:
        return Container(
          height: widget.thickness,
          color: AppCardColors.border,
        );
    }
  }
}

/// Visual style options for section dividers.
enum DividerType {
  /// Gradient line (purple fade).
  gradient,

  /// Blur effect with soft shadow.
  blur,

  /// Simple solid line.
  simple,
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Internal widget for staggered fade-in animations.
class _StaggeredAnimationWrapper extends StatefulWidget {
  const _StaggeredAnimationWrapper({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<_StaggeredAnimationWrapper> createState() =>
      _StaggeredAnimationWrapperState();
}

class _StaggeredAnimationWrapperState extends State<_StaggeredAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.normal,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AppCurves.gentle,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppCurves.smooth,
    ));

    // Stagger animation based on index
    Future.delayed(
      Duration(milliseconds: 50 * widget.index),
      () {
        if (mounted) _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// ✅ Phase 4.2.2 — Extended Containers Complete
///
/// **Implementation Summary:**
/// - 4 specialized container types
/// - Staggered entry animations
/// - Responsive layout support
/// - Glass effect integration
/// - Form validation states
/// - Multiple divider styles
///
/// **Component Hierarchy:**
/// ```
/// AppListContainer
///   └─ Scrollable list with header + staggered animations
///
/// AppFormContainer
///   └─ Glass form wrapper with validation states
///
/// AppCardGrid
///   └─ Responsive grid with auto column count
///
/// AppSectionDivider
///   └─ Gradient/blur/simple divider with label
/// ```
///
/// **Demo Layout Example:**
/// ```dart
/// class DashboardScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: SingleChildScrollView(
///         child: Column(
///           children: [
///             // Header stats grid
///             AppCardGrid(
///               crossAxisCount: 2,
///               children: [
///                 InfoCard(
///                   title: 'Casos Activos',
///                   value: '42',
///                   icon: Icons.folder_open,
///                   type: AppCardType.gradient,
///                 ),
///                 InfoCard(
///                   title: 'Documentos',
///                   value: '128',
///                   icon: Icons.description,
///                 ),
///                 InfoCard(
///                   title: 'Clientes',
///                   value: '35',
///                   icon: Icons.people,
///                 ),
///                 InfoCard(
///                   title: 'Audiencias',
///                   value: '12',
///                   icon: Icons.calendar_today,
///                 ),
///               ],
///             ),
///
///             // Section divider
///             AppSectionDivider(
///               label: 'Casos Recientes',
///               type: DividerType.gradient,
///             ),
///
///             // List of cases
///             AppListContainer(
///               title: 'Expedientes en Progreso',
///               actionLabel: 'Ver Todos',
///               onAction: () => Navigator.pushNamed(context, '/cases'),
///               children: [
///                 AppCard(
///                   onTap: () => navigateToCase('001'),
///                   child: ListTile(
///                     leading: Icon(Icons.folder, color: AppCardColors.gradientStart),
///                     title: Text('Caso #12345'),
///                     subtitle: Text('En progreso • Cliente: Juan Pérez'),
///                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
///                   ),
///                 ),
///                 AppCard(
///                   onTap: () => navigateToCase('002'),
///                   child: ListTile(
///                     leading: Icon(Icons.folder, color: AppCardColors.gradientStart),
///                     title: Text('Caso #12346'),
///                     subtitle: Text('Pendiente • Cliente: María García'),
///                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
///                   ),
///                 ),
///                 AppCard(
///                   onTap: () => navigateToCase('003'),
///                   child: ListTile(
///                     leading: Icon(Icons.folder, color: AppCardColors.gradientStart),
///                     title: Text('Caso #12347'),
///                     subtitle: Text('En revisión • Cliente: Pedro López'),
///                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
///                   ),
///                 ),
///               ],
///             ),
///
///             // Section divider
///             AppSectionDivider(
///               label: 'Acciones Rápidas',
///               type: DividerType.blur,
///             ),
///
///             // Action cards
///             AppCardGrid(
///               crossAxisCount: 1,
///               childAspectRatio: 2.5,
///               children: [
///                 ActionCard(
///                   title: 'Crear Nuevo Caso',
///                   description: 'Inicia un expediente legal completo',
///                   actionLabel: 'Crear',
///                   icon: Icons.add_circle,
///                   type: AppCardType.gradient,
///                   onAction: () => showDialog(
///                     context: context,
///                     builder: (_) => Dialog(
///                       child: AppFormContainer(
///                         title: 'Nuevo Caso',
///                         description: 'Completa los datos del expediente',
///                         children: [
///                           TextField(
///                             decoration: InputDecoration(
///                               labelText: 'Número de caso',
///                               border: OutlineInputBorder(),
///                             ),
///                           ),
///                           SizedBox(height: 16),
///                           TextField(
///                             decoration: InputDecoration(
///                               labelText: 'Nombre del cliente',
///                               border: OutlineInputBorder(),
///                             ),
///                           ),
///                           SizedBox(height: 16),
///                           TextField(
///                             decoration: InputDecoration(
///                               labelText: 'Descripción',
///                               border: OutlineInputBorder(),
///                             ),
///                             maxLines: 3,
///                           ),
///                         ],
///                         actions: [
///                           AppButton.secondary(
///                             label: 'Cancelar',
///                             onPressed: () => Navigator.pop(context),
///                           ),
///                           AppButton.primary(
///                             label: 'Guardar',
///                             icon: Icons.save,
///                             onPressed: () {
///                               // Save logic
///                               Navigator.pop(context);
///                             },
///                           ),
///                         ],
///                       ),
///                     ),
///                   ),
///                 ),
///                 ActionCard(
///                   title: 'Agendar Audiencia',
///                   description: 'Programa una fecha de comparecencia',
///                   actionLabel: 'Agendar',
///                   icon: Icons.calendar_today,
///                   type: AppCardType.glass,
///                   onAction: () => showScheduleDialog(context),
///                 ),
///               ],
///             ),
///
///             SizedBox(height: 32),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// **Key Features:**
/// - Staggered animations (50ms delay per item)
/// - Responsive grid (1-4 columns auto)
/// - Glass form wrapper with validation
/// - Three divider styles (gradient/blur/simple)
/// - Smooth entry animations (fade + slide)
/// - Performance optimized (const constructors)
