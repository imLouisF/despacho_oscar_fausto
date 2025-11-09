import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';

/// SocialFramework - Main navigation container for Social Legal Framework
/// 
/// Provides a Cupertino-inspired tab-based navigation system that organizes
/// the main user experience across five core sections.
/// 
/// Architecture:
/// - Uses CupertinoTabBar for bottom navigation
/// - IndexedStack maintains state across tabs
/// - Smooth transitions with AppMicroStyle animations
/// - Modular tab structure for easy expansion
/// 
/// Usage:
/// ```dart
/// MaterialApp(
///   home: SocialFramework(),
/// )
/// ```
/// 
/// The framework coordinates:
/// - Home feed and dashboard
/// - Legal cases management
/// - Calendar and scheduling
/// - Internal messaging
/// - User profile and settings
class SocialFramework extends StatefulWidget {
  const SocialFramework({super.key});

  @override
  State<SocialFramework> createState() => _SocialFrameworkState();
}

class _SocialFrameworkState extends State<SocialFramework> {
  /// Current selected tab index
  /// Drives both bottom navigation and content display
  int _selectedIndex = 0;

  /// Handle tab selection changes
  /// Updates state and triggers transition animation
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main content area with tab-based navigation
      // Uses IndexedStack to preserve state across tabs
      body: AnimatedSwitcher(
        duration: AppMicroStyle.defaultAnimationDuration,
        switchInCurve: AppMicroStyle.defaultCurve,
        switchOutCurve: AppMicroStyle.defaultCurve,
        transitionBuilder: (child, animation) {
          // Fade transition for smooth tab switches
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(_selectedIndex),
          index: _selectedIndex,
          children: const [
            HomeTab(),
            CasesTab(),
            AgendaTab(),
            ChatTab(),
            ProfileTab(),
          ],
        ),
      ),

      // Bottom navigation bar - Cupertino style
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  /// Builds the CupertinoTabBar bottom navigation
  /// 
  /// Integrates with theme colors and microstyle system for:
  /// - Consistent iconography (outlined icons)
  /// - Theme-aware colors (primary, background)
  /// - Subtle shadow elevation
  /// - Smooth active/inactive transitions
  Widget _buildBottomNavigation(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: const [
          // Subtle elevation using microstyle shadow
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
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
                context,
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Inicio',
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.folder_open_outlined,
                activeIcon: Icons.folder_open,
                label: 'Casos',
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today,
                label: 'Agenda',
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.chat_bubble_outline,
                activeIcon: Icons.chat_bubble,
                label: 'Chat',
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds individual navigation item with active/inactive states
  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final theme = Theme.of(context);
    final isSelected = _selectedIndex == index;
    
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTabSelected(index),
          borderRadius: BorderRadius.circular(AppMicroStyle.radiusSmall),
          child: AnimatedContainer(
            duration: AppMicroStyle.fastAnimationDuration,
            curve: AppMicroStyle.defaultCurve,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with active/inactive state
                AnimatedSwitcher(
                  duration: AppMicroStyle.fastAnimationDuration,
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    key: ValueKey<bool>(isSelected),
                    color: isSelected
                        ? theme.primaryColor
                        : Colors.grey.withValues(alpha: 0.6),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                // Label with color transition
                AnimatedDefaultTextStyle(
                  duration: AppMicroStyle.fastAnimationDuration,
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected
                        ? theme.primaryColor
                        : Colors.grey.withValues(alpha: 0.6),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== Tab Placeholder Widgets ====================
// Each tab is a skeleton that will host independent UI components
// Currently displays centered title - ready for content injection

/// Home Tab - Dashboard and main feed
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Inicio',
          style: AppTypography.titleMedium,
        ),
      ),
    );
  }
}

/// Cases Tab - Legal cases management
class CasesTab extends StatelessWidget {
  const CasesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Casos',
          style: AppTypography.titleMedium,
        ),
      ),
    );
  }
}

/// Agenda Tab - Calendar and scheduling
class AgendaTab extends StatelessWidget {
  const AgendaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Agenda',
          style: AppTypography.titleMedium,
        ),
      ),
    );
  }
}

/// Chat Tab - Internal messaging and communication
class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Chat',
          style: AppTypography.titleMedium,
        ),
      ),
    );
  }
}

/// Profile Tab - User profile and settings
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Perfil',
          style: AppTypography.titleMedium,
        ),
      ),
    );
  }
}
