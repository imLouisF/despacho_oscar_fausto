/// App Navigation Core — Phase 6.1
///
/// Cupertino-style navigation system with Purple Jurídico design integration.
/// Provides smooth iOS-style transitions while maintaining Material functionality.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.lightTheme,
///   home: AppNavigation(userName: 'Oscar Fausto'),
/// )
/// ```
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_components/ui_components_index.dart';
import '../../features/feed/feed_simulation.dart';
import '../../features/feed/models/feed_event.dart';
import '../../features/feed/widgets/feed_list.dart';
import '../../features/profile/profile_view.dart';

/// Root navigation widget using Cupertino tab scaffold.
///
/// Provides iOS-style navigation with Purple Jurídico branding and smooth
/// transitions between Feed and Profile tabs.
class AppNavigation extends StatefulWidget {
  /// Current user name
  final String userName;

  /// Optional user ID
  final String? userId;

  const AppNavigation({
    super.key,
    required this.userName,
    this.userId,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late final NavigationDataLayer _dataLayer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _dataLayer = NavigationDataLayer(userName: widget.userName);
    _dataLayer.initialize();
  }

  @override
  void dispose() {
    _dataLayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return CupertinoTabScaffold(
      tabBar: _buildTabBar(isDark),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return _buildFeedTab(isDark);
              case 1:
                return _buildProfileTab(isDark);
              default:
                return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  /// Builds Cupertino tab bar with Purple Jurídico styling
  CupertinoTabBar _buildTabBar(bool isDark) {
    return CupertinoTabBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      backgroundColor: isDark
          ? AppColors.surfaceDark.withOpacity(0.95)
          : AppColors.surface.withOpacity(0.95),
      activeColor: AppColors.primary,
      inactiveColor:
          (isDark ? AppColors.textSecondary : AppColors.textSecondary)
              .withOpacity(0.6),
      iconSize: 24,
      height: 60,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.feed),
          label: 'Actividad',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }

  /// Builds Feed tab with navigation bar
  Widget _buildFeedTab(bool isDark) {
    return CupertinoPageScaffold(
      navigationBar: _buildNavigationBar(
        title: 'Actividad',
        isDark: isDark,
        showSync: true,
      ),
      child: SafeArea(
        top: false,
        child: ValueListenableBuilder<List<FeedEvent>>(
          valueListenable: _dataLayer.feedEventsNotifier,
          builder: (context, events, _) {
            return CustomScrollView(
              slivers: [
                // Additional spacing for navigation bar
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 44,
                  ),
                ),

                // Feed list
                SliverFillRemaining(
                  child: FeedList(
                    initialEvents: events,
                    showDateHeaders: true,
                    compact: false,
                    onRefresh: () async {
                      await _dataLayer.refreshData();
                      return _dataLayer.feedEventsNotifier.value;
                    },
                    onEventTap: (event) {
                      _showEventDetail(context, event);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Builds Profile tab with navigation bar
  Widget _buildProfileTab(bool isDark) {
    return CupertinoPageScaffold(
      navigationBar: _buildNavigationBar(
        title: 'Perfil',
        isDark: isDark,
        showSync: false,
      ),
      child: ProfileView(
        userId: widget.userId,
        userName: widget.userName,
        role: 'Abogado Senior',
        specialization: 'Derecho Corporativo',
        simulation: _dataLayer.feedSimulation,
      ),
    );
  }

  /// Builds translucent navigation bar with gradient tint
  CupertinoNavigationBar _buildNavigationBar({
    required String title,
    required bool isDark,
    bool showSync = false,
  }) {
    return CupertinoNavigationBar(
      middle: Text(
        title,
        style: AppTypography.titleMedium.copyWith(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: isDark
          ? AppColors.surfaceDark.withOpacity(0.8)
          : AppColors.surface.withOpacity(0.8),
      border: Border(
        bottom: BorderSide(
          color: (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
              .withOpacity(0.1),
          width: 0.5,
        ),
      ),
      trailing: showSync
          ? ValueListenableBuilder<bool>(
              valueListenable: _dataLayer.isSyncingNotifier,
              builder: (context, isSyncing, _) {
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: isSyncing ? null : _dataLayer.refreshData,
                  child: isSyncing
                      ? const CupertinoActivityIndicator()
                      : Icon(
                          CupertinoIcons.refresh,
                          color: AppColors.primary,
                          size: 22,
                        ),
                );
              },
            )
          : null,
    );
  }

  /// Shows event detail as Cupertino modal
  void _showEventDetail(BuildContext context, FeedEvent event) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(event.title),
        content: Text(event.description ?? 'Sin descripción'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// NAVIGATION DATA LAYER
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Shared data layer for navigation state management.
///
/// Provides reactive data streams and synchronization across tabs.
/// Maintains MVU architecture compatibility.
class NavigationDataLayer {
  /// Current user name
  final String userName;

  /// Feed simulation service
  final FeedSimulation feedSimulation;

  /// Feed events notifier
  final ValueNotifier<List<FeedEvent>> feedEventsNotifier;

  /// Sync state notifier
  final ValueNotifier<bool> isSyncingNotifier;

  /// Last sync timestamp
  DateTime? lastSyncTime;

  NavigationDataLayer({required this.userName})
      : feedSimulation = FeedSimulation(),
        feedEventsNotifier = ValueNotifier<List<FeedEvent>>([]),
        isSyncingNotifier = ValueNotifier<bool>(false);

  /// Initializes data from simulation
  Future<void> initialize() async {
    final events = await feedSimulation.fetchFeed();
    feedEventsNotifier.value = events;
    lastSyncTime = DateTime.now();
  }

  /// Refreshes data with animation delay
  Future<void> refreshData() async {
    if (isSyncingNotifier.value) return;

    isSyncingNotifier.value = true;

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Refresh feed events
      final events = await feedSimulation.refreshFeed();
      feedEventsNotifier.value = events;
      lastSyncTime = DateTime.now();
    } finally {
      isSyncingNotifier.value = false;
    }
  }

  /// Disposes notifiers
  void dispose() {
    feedEventsNotifier.dispose();
    isSyncingNotifier.dispose();
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// CUPERTINO PAGE TRANSITIONS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Custom page transitions builder for iOS-style navigation.
///
/// Provides smooth horizontal slide transitions with Purple Jurídico timing.
class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const AppPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Use Cupertino-style transitions
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: false,
      child: child,
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// APP THEME CONFIGURATION
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Theme configuration with Cupertino page transitions.
///
/// Integrates Purple Jurídico design tokens with iOS-style navigation.
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: AppPageTransitionsBuilder(),
          TargetPlatform.iOS: AppPageTransitionsBuilder(),
        },
      ),
      // Cupertino overrides
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: AppPageTransitionsBuilder(),
          TargetPlatform.iOS: AppPageTransitionsBuilder(),
        },
      ),
      // Cupertino overrides
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// NAVIGATION UTILITIES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/// Utility functions for navigation operations.
class AppNavigationUtils {
  AppNavigationUtils._();

  /// Pushes a new page with Cupertino transition
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(
      CupertinoPageRoute<T>(
        builder: (_) => page,
      ),
    );
  }

  /// Pushes a new page and removes all previous routes
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      CupertinoPageRoute<T>(
        builder: (_) => page,
      ),
      (route) => false,
    );
  }

  /// Shows a Cupertino modal sheet
  static Future<T?> showModal<T>(
    BuildContext context,
    Widget child, {
    bool useRootNavigator = true,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (_) => child,
    );
  }

  /// Shows a Cupertino alert dialog
  static Future<void> showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'OK',
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Shows a Cupertino confirmation dialog
  static Future<bool> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
  }) async {
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
