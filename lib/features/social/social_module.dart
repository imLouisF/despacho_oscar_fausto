/// Social Module — Phase 5.4
///
/// Unified module orchestrating Feed and Profile views with shared state.
/// Provides seamless navigation and data synchronization between views.
///
/// Example:
/// ```dart
/// MaterialApp(
///   home: SocialModule(userName: 'Oscar Fausto'),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/ui_components/ui_components_index.dart';
import '../feed/feed_simulation.dart';
import '../feed/models/feed_event.dart';
import '../feed/widgets/feed_list.dart';
import '../profile/profile_view.dart';

/// Main social module widget with Feed and Profile tabs.
///
/// Manages shared state between views and provides synchronized data updates.
class SocialModule extends StatefulWidget {
  /// Current user name
  final String userName;

  /// Optional user ID
  final String? userId;

  const SocialModule({
    super.key,
    required this.userName,
    this.userId,
  });

  @override
  State<SocialModule> createState() => _SocialModuleState();
}

class _SocialModuleState extends State<SocialModule>
    with TickerProviderStateMixin {
  late SocialDataSimulation _dataSimulation;
  late TabController _tabController;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  int _currentIndex = 0;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();

    _dataSimulation = SocialDataSimulation(userName: widget.userName);

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });

    // FAB animation
    _fabController = AnimationController(
      vsync: this,
      duration: AppMotion.fast,
    );

    _fabAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.easeInOut,
    );

    _fabController.forward();

    // Load initial data
    _dataSimulation.initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fabController.dispose();
    _dataSimulation.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() => _isSyncing = true);

    await _dataSimulation.refreshData();

    setState(() => _isSyncing = false);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Stack(
        children: [
          // Main content with tabs
          TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildFeedTab(),
              _buildProfileTab(),
            ],
          ),

          // Sync FAB
          if (_currentIndex == 0) _buildSyncButton(isDark),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  /// Builds Feed tab with integrated FeedList
  Widget _buildFeedTab() {
    return ValueListenableBuilder<List<FeedEvent>>(
      valueListenable: _dataSimulation.feedEventsNotifier,
      builder: (context, events, _) {
        return Column(
          children: [
            _buildFeedHeader(),
            Expanded(
              child: FeedList(
                initialEvents: events,
                showDateHeaders: true,
                compact: false,
                onRefresh: () async {
                  await _handleRefresh();
                  return _dataSimulation.feedEventsNotifier.value;
                },
                onEventTap: (event) {
                  // Navigate to event detail (future implementation)
                  _showEventDetail(event);
                },
              ),
            ),
            if (_dataSimulation.lastSyncTime != null) _buildSyncInfo(),
          ],
        );
      },
    );
  }

  /// Builds Feed header with gradient
  Widget _buildFeedHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing16,
            vertical: AppSpacing.spacing16,
          ),
          child: Row(
            children: [
              Icon(
                Icons.feed,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: AppSpacing.spacing12),
              Text(
                'Actividad',
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (_isSyncing)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds Profile tab with metrics from shared state
  Widget _buildProfileTab() {
    return ValueListenableBuilder<ProfileMetrics>(
      valueListenable: _dataSimulation.metricsNotifier,
      builder: (context, metrics, _) {
        return ProfileView(
          userId: widget.userId,
          userName: widget.userName,
          role: 'Abogado Senior',
          specialization: 'Derecho Corporativo',
          simulation: _dataSimulation.feedSimulation,
        );
      },
    );
  }

  /// Builds bottom navigation bar
  Widget _buildBottomNav(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.feed,
                label: 'Actividad',
                index: 0,
                isDark: isDark,
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Perfil',
                index: 1,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds individual nav item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isDark,
  }) {
    final isActive = _currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _currentIndex = index;
              _tabController.animateTo(index);
            });
          },
          child: AnimatedContainer(
            duration: AppMotion.fast,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.spacing8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isActive
                      ? AppColors.primary
                      : (isDark
                          ? AppColors.textSecondary
                          : AppColors.textSecondary),
                  size: 24,
                ),
                const SizedBox(height: AppSpacing.spacing4),
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: isActive
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.textSecondary
                            : AppColors.textSecondary),
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds floating sync button
  Widget _buildSyncButton(bool isDark) {
    return Positioned(
      right: AppSpacing.spacing16,
      bottom: 80,
      child: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: _isSyncing ? null : _handleRefresh,
          backgroundColor: AppColors.primary,
          child: _isSyncing
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(
                  Icons.sync,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }

  /// Builds sync info footer
  Widget _buildSyncInfo() {
    final lastSync = _dataSimulation.lastSyncTime;
    if (lastSync == null) return const SizedBox.shrink();

    final timeAgo = _getTimeAgo(lastSync);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing16,
        vertical: AppSpacing.spacing8,
      ),
      child: Text(
        'Última actualización: $timeAgo',
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Shows event detail dialog
  void _showEventDetail(FeedEvent event) {
    showAppAlert(
      context: context,
      title: event.title,
      message: event.description ?? 'Sin descripción',
      confirmText: 'Cerrar',
    );
  }

  /// Converts DateTime to relative Spanish string
  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return 'Hace ${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes}m';
    } else {
      return DateFormat('HH:mm').format(time);
    }
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SHARED STATE LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Simulated data layer for Feed + Profile state synchronization.
///
/// Provides reactive data streams using ValueNotifier for real-time updates.
/// Simulates local storage (would be Hive/Firestore in production).
class SocialDataSimulation {
  /// Current user name
  final String userName;

  /// Feed simulation service
  final FeedSimulation feedSimulation;

  /// Feed events notifier
  final ValueNotifier<List<FeedEvent>> feedEventsNotifier;

  /// Profile metrics notifier
  final ValueNotifier<ProfileMetrics> metricsNotifier;

  /// Last sync timestamp
  DateTime? lastSyncTime;

  SocialDataSimulation({required this.userName})
      : feedSimulation = FeedSimulation(),
        feedEventsNotifier = ValueNotifier<List<FeedEvent>>([]),
        metricsNotifier = ValueNotifier<ProfileMetrics>(
          ProfileMetrics(
            casesClosed: 47,
            activeClients: 23,
            meetingsThisMonth: 12,
          ),
        );

  /// Initializes data from simulation
  Future<void> initialize() async {
    final events = await feedSimulation.fetchFeed();
    feedEventsNotifier.value = events;
    lastSyncTime = DateTime.now();
  }

  /// Refreshes data with random variations
  Future<void> refreshData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Refresh feed events
    final events = await feedSimulation.refreshFeed();
    feedEventsNotifier.value = events;

    // Update metrics with slight random variation
    final currentMetrics = metricsNotifier.value;
    metricsNotifier.value = ProfileMetrics(
      casesClosed: currentMetrics.casesClosed + _randomVariation(-2, 3),
      activeClients: currentMetrics.activeClients + _randomVariation(-1, 2),
      meetingsThisMonth:
          currentMetrics.meetingsThisMonth + _randomVariation(-1, 2),
    );

    lastSyncTime = DateTime.now();
  }

  /// Generates random variation for metrics
  int _randomVariation(int min, int max) {
    final random = DateTime.now().millisecondsSinceEpoch % (max - min + 1);
    return min + random;
  }

  /// Disposes notifiers
  void dispose() {
    feedEventsNotifier.dispose();
    metricsNotifier.dispose();
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// DATA MODELS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Profile metrics data model.
///
/// Represents key performance indicators for legal professionals.
class ProfileMetrics {
  /// Number of closed cases
  final int casesClosed;

  /// Number of active clients
  final int activeClients;

  /// Number of meetings this month
  final int meetingsThisMonth;

  const ProfileMetrics({
    required this.casesClosed,
    required this.activeClients,
    required this.meetingsThisMonth,
  });

  /// Creates a copy with optional field replacements
  ProfileMetrics copyWith({
    int? casesClosed,
    int? activeClients,
    int? meetingsThisMonth,
  }) {
    return ProfileMetrics(
      casesClosed: casesClosed ?? this.casesClosed,
      activeClients: activeClients ?? this.activeClients,
      meetingsThisMonth: meetingsThisMonth ?? this.meetingsThisMonth,
    );
  }

  @override
  String toString() {
    return 'ProfileMetrics(cases: $casesClosed, clients: $activeClients, '
        'meetings: $meetingsThisMonth)';
  }
}
