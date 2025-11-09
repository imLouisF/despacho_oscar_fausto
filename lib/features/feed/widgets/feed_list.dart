/// Feed List Widget — Phase 5.2
///
/// Renders a scrollable timeline of feed events grouped by date.
/// Features pull-to-refresh, staggered animations, and empty states.
///
/// Example:
/// ```dart
/// FeedList(
///   events: feedEvents,
///   onRefresh: () => feedSimulation.refreshFeed(),
///   onEventTap: (event) => navigateToDetail(event),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../../../core/ui_components/ui_components_index.dart';
import '../models/feed_event.dart';
import '../feed_simulation.dart';
import 'feed_card.dart';
import 'package:intl/intl.dart';

/// A scrollable list of feed events with timeline grouping.
///
/// Groups events by date with sticky headers, supports pull-to-refresh,
/// and provides staggered entry animations for a polished UX.
class FeedList extends StatefulWidget {
  /// Initial events to display (can be null for async loading)
  final List<FeedEvent>? initialEvents;

  /// Callback for pull-to-refresh
  final Future<List<FeedEvent>> Function()? onRefresh;

  /// Callback when an event card is tapped
  final void Function(FeedEvent)? onEventTap;

  /// Whether to show compact card layout
  final bool compact;

  /// Whether to show date group headers
  final bool showDateHeaders;

  /// Maximum number of events to display (null = all)
  final int? maxEvents;

  /// Feed simulation service (used if initialEvents is null)
  final FeedSimulation? simulation;

  const FeedList({
    super.key,
    this.initialEvents,
    this.onRefresh,
    this.onEventTap,
    this.compact = false,
    this.showDateHeaders = true,
    this.maxEvents,
    this.simulation,
  });

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  late Future<List<FeedEvent>> _eventsFuture;
  List<FeedEvent> _events = [];
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _initializeEvents();
  }

  void _initializeEvents() {
    if (widget.initialEvents != null) {
      _events = widget.initialEvents!;
      _eventsFuture = Future.value(_events);
    } else if (widget.simulation != null) {
      _eventsFuture = widget.simulation!.fetchFeed();
    } else {
      // Fallback: create simulation instance
      final simulation = FeedSimulation();
      _eventsFuture = simulation.fetchFeed();
    }
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() => _isRefreshing = true);

    try {
      if (widget.onRefresh != null) {
        final newEvents = await widget.onRefresh!();
        setState(() {
          _events = newEvents;
          _eventsFuture = Future.value(newEvents);
        });
      } else if (widget.simulation != null) {
        final newEvents = await widget.simulation!.refreshFeed();
        setState(() {
          _events = newEvents;
          _eventsFuture = Future.value(newEvents);
        });
      }
    } finally {
      setState(() => _isRefreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedEvent>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        }

        final events = snapshot.data ?? [];
        if (events.isEmpty) {
          return _buildEmptyState();
        }

        // Apply max events limit if specified
        final displayEvents = widget.maxEvents != null
            ? events.take(widget.maxEvents!).toList()
            : events;

        return _buildFeedList(displayEvents);
      },
    );
  }

  /// Builds the main scrollable feed list
  Widget _buildFeedList(List<FeedEvent> events) {
    if (widget.showDateHeaders) {
      return _buildGroupedList(events);
    } else {
      return _buildSimpleList(events);
    }
  }

  /// Builds feed with date group headers
  Widget _buildGroupedList(List<FeedEvent> events) {
    // Group events by date
    final grouped = <String, List<FeedEvent>>{};
    for (final event in events) {
      final dateKey = _getDateKey(event.timestamp);
      grouped.putIfAbsent(dateKey, () => []).add(event);
    }

    final groupKeys = grouped.keys.toList();

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppColors.primary,
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.surfaceDark
              : AppColors.surface,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: widget.compact ? AppSpacing.spacing8 : AppSpacing.spacing12,
        ),
        itemCount: groupKeys.length,
        itemBuilder: (context, groupIndex) {
          final dateKey = groupKeys[groupIndex];
          final groupEvents = grouped[dateKey]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateHeader(dateKey),
              ...groupEvents.asMap().entries.map((entry) {
                final eventIndex = entry.key;
                final event = entry.value;

                // Calculate staggered delay (50ms per card)
                final delay = Duration(milliseconds: eventIndex * 50);

                return FeedCard(
                  event: event,
                  onTap:
                      widget.onEventTap != null
                          ? () => widget.onEventTap!(event)
                          : null,
                  compact: widget.compact,
                  entryDelay: delay,
                  showMetadata: true,
                );
              }),
              if (groupIndex < groupKeys.length - 1)
                const SizedBox(height: AppSpacing.spacing12),
            ],
          );
        },
      ),
    );
  }

  /// Builds simple list without grouping
  Widget _buildSimpleList(List<FeedEvent> events) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: AppColors.primary,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: widget.compact ? AppSpacing.spacing8 : AppSpacing.spacing12,
        ),
        itemCount: events.length,
        separatorBuilder: (context, index) => SizedBox(
          height: widget.compact ? AppSpacing.spacing4 : AppSpacing.spacing8,
        ),
        itemBuilder: (context, index) {
          final event = events[index];
          final delay = Duration(milliseconds: index * 50);

          return FeedCard(
            event: event,
            onTap:
                widget.onEventTap != null
                    ? () => widget.onEventTap!(event)
                    : null,
            compact: widget.compact,
            entryDelay: delay,
            showMetadata: true,
          );
        },
      ),
    );
  }

  /// Builds date header with divider
  Widget _buildDateHeader(String dateKey) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        left: widget.compact ? AppSpacing.spacing12 : AppSpacing.spacing16,
        right: widget.compact ? AppSpacing.spacing12 : AppSpacing.spacing16,
        top: AppSpacing.spacing12,
        bottom: AppSpacing.spacing8,
      ),
      child: Row(
        children: [
          // Purple accent line
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
          ),
          const SizedBox(width: AppSpacing.spacing8),

          // Date label
          Text(
            _getDateLabel(dateKey),
            style: AppTypography.labelLarge.copyWith(
              color:
                  isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(width: AppSpacing.spacing8),

          // Divider line
          Expanded(
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                        .withOpacity(0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds loading state with shimmer effect
  Widget _buildLoadingState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.spacing12),
            Text(
              'Cargando actividades...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds empty state
  Widget _buildEmptyState() {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon with gradient
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.primaryDark.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.feed_outlined,
                size: 64,
                color: AppColors.primary.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: AppSpacing.spacing16),

            // Empty state title
            Text(
              'Sin actividades',
              style: AppTypography.titleMedium.copyWith(
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppSpacing.spacing8),

            // Empty state subtitle
            Text(
              'No hay eventos recientes para mostrar.\nLas nuevas actividades aparecerán aquí.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: AppSpacing.spacing24),

            // Refresh button
            AppButton.secondary(
              label: 'Actualizar',
              icon: Icons.refresh,
              onPressed: _handleRefresh,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds error state
  Widget _buildErrorState(String error) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              padding: const EdgeInsets.all(AppSpacing.spacing24),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: const Color(0xFFE53935).withOpacity(0.8),
              ),
            ),

            const SizedBox(height: AppSpacing.spacing16),

            // Error title
            Text(
              'Error al cargar',
              style: AppTypography.titleMedium.copyWith(
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: AppSpacing.spacing8),

            // Error message
            Text(
              'No se pudieron cargar las actividades.\nIntenta nuevamente.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),

            const SizedBox(height: AppSpacing.spacing24),

            // Retry button
            AppButton.primary(
              label: 'Reintentar',
              icon: Icons.refresh,
              onPressed: () {
                setState(() {
                  _initializeEvents();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Converts timestamp to date key (YYYY-MM-DD)
  String _getDateKey(DateTime timestamp) {
    return '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
  }

  /// Converts date key to human-readable label in Spanish
  String _getDateLabel(String dateKey) {
    final parts = dateKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final date = DateTime(year, month, day);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Hoy';
    } else if (date == yesterday) {
      return 'Ayer';
    } else if (now.difference(date).inDays < 7) {
      // Show day of week for last 7 days
      return DateFormat('EEEE', 'es').format(date);
    } else if (date.year == now.year) {
      // Show "day month" for this year
      return DateFormat('d MMMM', 'es').format(date);
    } else {
      // Show "day month year" for previous years
      return DateFormat('d MMMM y', 'es').format(date);
    }
  }
}
