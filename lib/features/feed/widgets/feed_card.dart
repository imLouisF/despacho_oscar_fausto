/// Feed Card Widget — Phase 5.2
///
/// Displays a single feed event with Purple Jurídico design aesthetics.
/// Features animated entry, hover effects, and category-specific iconography.
///
/// Example:
/// ```dart
/// FeedCard(
///   event: feedEvent,
///   onTap: () => navigateToDetail(feedEvent.id),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../../../core/ui_components/ui_components_index.dart';
import '../models/feed_event.dart';
import 'package:intl/intl.dart';

/// A card component for displaying feed events in a timeline.
///
/// Integrates with Purple Jurídico design tokens for consistent styling,
/// motion, and theming. Supports compact and full display modes.
class FeedCard extends StatefulWidget {
  /// The feed event to display
  final FeedEvent event;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Whether to show compact layout (reduced padding/details)
  final bool compact;

  /// Animation delay for staggered entry (used by parent list)
  final Duration entryDelay;

  /// Whether to show metadata line (case ID, client, etc.)
  final bool showMetadata;

  const FeedCard({
    super.key,
    required this.event,
    this.onTap,
    this.compact = false,
    this.entryDelay = Duration.zero,
    this.showMetadata = true,
  });

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Entry animation: 200ms fade + vertical slide
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.03), // Slide from 10px below
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation after delay
    Future.delayed(widget.entryDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: Curves.easeOut,
              margin: EdgeInsets.symmetric(
                horizontal: widget.compact ? AppSpacing.spacing8 : AppSpacing.spacing12,
                vertical: widget.compact ? AppSpacing.spacing4 : AppSpacing.spacing8,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: _isHovered
                    ? Border.all(
                        width: 2,
                        color: Colors.transparent,
                      )
                    : null,
                gradient: _isHovered
                    ? LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.primaryDark.withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                boxShadow: _isHovered
                    ? [
                        AppShadow.soft.copyWith(
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : [AppShadow.soft],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.compact ? AppSpacing.spacing12 : AppSpacing.spacing16,
                      vertical: widget.compact ? AppSpacing.spacing8 : AppSpacing.spacing12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeader(context, isDark),
                        SizedBox(
                          height: widget.compact ? AppSpacing.spacing4 : AppSpacing.spacing8,
                        ),
                        _buildTitle(context, isDark),
                        if (widget.event.description != null &&
                            !widget.compact) ...[
                          const SizedBox(height: AppSpacing.spacing4),
                          _buildDescription(context, isDark),
                        ],
                        if (widget.showMetadata &&
                            widget.event.metadata != null) ...[
                          SizedBox(
                            height: widget.compact ? AppSpacing.spacing4 : AppSpacing.spacing8,
                          ),
                          _buildMetadata(context, isDark),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header row with icon, category badge, and timestamp
  Widget _buildHeader(BuildContext context, bool isDark) {
    return Row(
      children: [
        // Category icon
        _buildCategoryIcon(isDark),
        const SizedBox(width: AppSpacing.spacing8),

        // Category badge
        _buildCategoryBadge(context, isDark),

        const Spacer(),

        // Timestamp
        _buildTimestamp(context, isDark),
      ],
    );
  }

  /// Dynamic icon based on event category
  Widget _buildCategoryIcon(bool isDark) {
    final iconData = _getIconForCategory(widget.event.category);
    final iconColor = _getColorForCategory(widget.event.category, isDark);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.spacing4),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(
        iconData,
        size: widget.compact ? 18 : 20,
        color: iconColor,
      ),
    );
  }

  /// Category badge with text
  Widget _buildCategoryBadge(BuildContext context, bool isDark) {
    final categoryColor = _getColorForCategory(widget.event.category, isDark);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing8,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(
          color: categoryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        _getCategoryLabel(widget.event.category),
        style: AppTypography.labelSmall.copyWith(
          color: categoryColor,
          fontWeight: FontWeight.w600,
          fontSize: widget.compact ? 10 : 11,
        ),
      ),
    );
  }

  /// Relative timestamp (e.g., "hace 2 horas")
  Widget _buildTimestamp(BuildContext context, bool isDark) {
    final relativeTime = _getRelativeTime(widget.event.timestamp);

    return Text(
      relativeTime,
      style: AppTypography.labelSmall.copyWith(
        color: (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
            .withOpacity(0.6),
        fontSize: widget.compact ? 11 : 12,
      ),
    );
  }

  /// Event title with bold emphasis
  Widget _buildTitle(BuildContext context, bool isDark) {
    return Text(
      widget.event.title,
      style: (widget.compact
              ? AppTypography.bodyMedium
              : AppTypography.titleMedium)
          .copyWith(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        height: 1.3,
      ),
      maxLines: widget.compact ? 1 : 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Event description with reduced opacity
  Widget _buildDescription(BuildContext context, bool isDark) {
    return Text(
      widget.event.description!,
      style: AppTypography.bodySmall.copyWith(
        color: (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
            .withOpacity(0.7),
        height: 1.4,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Metadata line (case ID, author, etc.)
  Widget _buildMetadata(BuildContext context, bool isDark) {
    final metadata = widget.event.metadata!;
    final metadataItems = <String>[];

    // Extract relevant metadata
    if (metadata.containsKey('caseId')) {
      metadataItems.add('Caso ${metadata['caseId']}');
    }
    if (metadata.containsKey('documentName')) {
      metadataItems.add(metadata['documentName']);
    }
    if (metadata.containsKey('amount')) {
      final amount = metadata['amount'];
      final currency = metadata['currency'] ?? 'MXN';
      metadataItems.add('\$$amount $currency');
    }
    if (metadata.containsKey('location')) {
      metadataItems.add(metadata['location']);
    }

    // Add author if no other metadata
    if (metadataItems.isEmpty) {
      metadataItems.add('por ${widget.event.author}');
    }

    return Wrap(
      spacing: AppSpacing.spacing4,
      runSpacing: 2.0,
      children: metadataItems.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing8,
            vertical: 2.0,
          ),
          decoration: BoxDecoration(
            color: (isDark ? AppColors.surfaceDark : AppColors.surface)
                .withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(
              color:
                  (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                      .withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Text(
            item,
            style: AppTypography.labelSmall.copyWith(
              color:
                  (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                      .withOpacity(0.6),
              fontSize: 10,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Returns icon for each category
  IconData _getIconForCategory(FeedEventCategory category) {
    switch (category) {
      case FeedEventCategory.caseManagement:
        return Icons.work_outline;
      case FeedEventCategory.documents:
        return Icons.description_outlined;
      case FeedEventCategory.scheduling:
        return Icons.event_outlined;
      case FeedEventCategory.financial:
        return Icons.payments_outlined;
      case FeedEventCategory.clientRelations:
        return Icons.people_outline;
      case FeedEventCategory.courtProceedings:
        return Icons.gavel_outlined;
      case FeedEventCategory.teamCollaboration:
        return Icons.chat_bubble_outline;
      case FeedEventCategory.notifications:
        return Icons.notifications_outlined;
    }
  }

  /// Returns color for each category
  Color _getColorForCategory(FeedEventCategory category, bool isDark) {
    switch (category) {
      case FeedEventCategory.caseManagement:
        return AppColors.primary;
      case FeedEventCategory.documents:
        return const Color(0xFF3949AB); // Indigo
      case FeedEventCategory.scheduling:
        return const Color(0xFF00897B); // Teal
      case FeedEventCategory.financial:
        return const Color(0xFF43A047); // Green
      case FeedEventCategory.clientRelations:
        return const Color(0xFFFB8C00); // Orange
      case FeedEventCategory.courtProceedings:
        return const Color(0xFFE53935); // Red
      case FeedEventCategory.teamCollaboration:
        return const Color(0xFF8E24AA); // Purple
      case FeedEventCategory.notifications:
        return const Color(0xFF757575); // Gray
    }
  }

  /// Returns Spanish label for category
  String _getCategoryLabel(FeedEventCategory category) {
    switch (category) {
      case FeedEventCategory.caseManagement:
        return 'Casos';
      case FeedEventCategory.documents:
        return 'Documentos';
      case FeedEventCategory.scheduling:
        return 'Agenda';
      case FeedEventCategory.financial:
        return 'Finanzas';
      case FeedEventCategory.clientRelations:
        return 'Clientes';
      case FeedEventCategory.courtProceedings:
        return 'Tribunal';
      case FeedEventCategory.teamCollaboration:
        return 'Equipo';
      case FeedEventCategory.notifications:
        return 'Avisos';
    }
  }

  /// Converts timestamp to relative time in Spanish
  String _getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inMinutes < 60) {
      return 'hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'hace ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return 'hace ${difference.inDays} d';
    } else {
      return DateFormat('d MMM', 'es').format(timestamp);
    }
  }
}
