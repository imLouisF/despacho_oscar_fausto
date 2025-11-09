/// Profile Dynamic View — Phase 5.3
///
/// Professional profile screen for lawyers with Purple Jurídico design.
/// Integrates with Feed Simulation System and maintains visual consistency.
///
/// Example:
/// ```dart
/// ProfileView(
///   userId: 'user_001',
///   userName: 'Oscar Fausto',
/// )
/// ```
library;

import 'package:flutter/material.dart';
import '../../core/ui_components/ui_components_index.dart';
import '../feed/feed_simulation.dart';
import '../feed/models/feed_event.dart';
import '../feed/widgets/feed_list.dart';
import '../feed/widgets/feed_card.dart';

/// Main profile view for legal professionals.
///
/// Displays user information, metrics, activity highlights, and recent feed.
/// Fully responsive with dark mode support and smooth animations.
class ProfileView extends StatefulWidget {
  /// User ID for data fetching
  final String? userId;

  /// Display name of the user
  final String userName;

  /// User's professional role
  final String role;

  /// Legal specialization
  final String specialization;

  /// Avatar image URL or asset path
  final String? avatarUrl;

  /// Feed simulation service
  final FeedSimulation? simulation;

  const ProfileView({
    super.key,
    this.userId,
    required this.userName,
    this.role = 'Abogado Senior',
    this.specialization = 'Derecho Corporativo',
    this.avatarUrl,
    this.simulation,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late FeedSimulation _simulation;

  // Mock metrics (in real app, fetch from API)
  final int _casesClosed = 47;
  final int _activeClients = 23;
  final int _meetingsThisMonth = 12;

  @override
  void initState() {
    super.initState();

    _simulation = widget.simulation ?? FeedSimulation();

    // Header entry animation
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
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation
    _controller.forward();
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

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(isDark),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.spacing24),
                _buildMetricsSection(isDark),
                const SizedBox(height: AppSpacing.spacing24),
                _buildBioSection(isDark),
                const SizedBox(height: AppSpacing.spacing24),
                _buildHighlightsSection(isDark),
                const SizedBox(height: AppSpacing.spacing24),
                _buildRecentActivityHeader(isDark),
              ],
            ),
          ),
          _buildRecentFeedSection(),
        ],
      ),
    );
  }

  /// Builds gradient app bar with avatar and name
  Widget _buildAppBar(bool isDark) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSpacing.spacing24),
                    _buildAvatar(),
                    const SizedBox(height: AppSpacing.spacing12),
                    _buildNameAndRole(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds circular avatar
  Widget _buildAvatar() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: widget.avatarUrl != null
            ? Image.network(
                widget.avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
              )
            : _buildDefaultAvatar(),
      ),
    );
  }

  /// Default avatar with initials
  Widget _buildDefaultAvatar() {
    final initials = widget.userName
        .split(' ')
        .take(2)
        .map((e) => e.isNotEmpty ? e[0] : '')
        .join()
        .toUpperCase();

    return Container(
      color: AppColors.primaryLight,
      child: Center(
        child: Text(
          initials,
          style: AppTypography.headlineLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds name and role text
  Widget _buildNameAndRole() {
    return Column(
      children: [
        Text(
          widget.userName,
          style: AppTypography.headlineMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.spacing4),
        Text(
          widget.role,
          style: AppTypography.bodyMedium.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.spacing4),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spacing12,
            vertical: AppSpacing.spacing4,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: Text(
            widget.specialization,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds metrics section with animated counters
  Widget _buildMetricsSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          if (isWide) {
            return Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.gavel,
                    label: 'Casos cerrados',
                    value: _casesClosed,
                    color: AppColors.primary,
                    isDark: isDark,
                    delay: Duration.zero,
                  ),
                ),
                const SizedBox(width: AppSpacing.spacing12),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.people_outline,
                    label: 'Clientes activos',
                    value: _activeClients,
                    color: const Color(0xFF00897B),
                    isDark: isDark,
                    delay: const Duration(milliseconds: 100),
                  ),
                ),
                const SizedBox(width: AppSpacing.spacing12),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.event,
                    label: 'Reuniones este mes',
                    value: _meetingsThisMonth,
                    color: const Color(0xFF3949AB),
                    isDark: isDark,
                    delay: const Duration(milliseconds: 200),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              _buildMetricCard(
                icon: Icons.gavel,
                label: 'Casos cerrados',
                value: _casesClosed,
                color: AppColors.primary,
                isDark: isDark,
                delay: Duration.zero,
              ),
              const SizedBox(height: AppSpacing.spacing12),
              _buildMetricCard(
                icon: Icons.people_outline,
                label: 'Clientes activos',
                value: _activeClients,
                color: const Color(0xFF00897B),
                isDark: isDark,
                delay: const Duration(milliseconds: 100),
              ),
              const SizedBox(height: AppSpacing.spacing12),
              _buildMetricCard(
                icon: Icons.event,
                label: 'Reuniones este mes',
                value: _meetingsThisMonth,
                color: const Color(0xFF3949AB),
                isDark: isDark,
                delay: const Duration(milliseconds: 200),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Builds individual metric card with count-up animation
  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required int value,
    required Color color,
    required bool isDark,
    required Duration delay,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1200),
      tween: Tween(begin: 0.0, end: value.toDouble()),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.spacing16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: [AppShadow.medium],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: color,
              ),
              const SizedBox(height: AppSpacing.spacing8),
              Text(
                animatedValue.toInt().toString(),
                style: AppTypography.headlineLarge.copyWith(
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.spacing4),
              Text(
                label,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds professional bio section
  Widget _buildBioSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.spacing16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [AppShadow.soft],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.spacing8),
                Text(
                  'Sobre mí',
                  style: AppTypography.titleMedium.copyWith(
                    color:
                        isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spacing12),
            Text(
              'Abogado especializado en derecho corporativo con más de 15 años de experiencia. '
              'Enfocado en fusiones y adquisiciones, contratos comerciales, y asesoría estratégica '
              'para empresas medianas y grandes en México.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds highlights section with horizontal scroll
  Widget _buildHighlightsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
          child: Row(
            children: [
              Icon(
                Icons.star_outline,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.spacing8),
              Text(
                'Actividad destacada',
                style: AppTypography.titleMedium.copyWith(
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spacing12),
        SizedBox(
          height: 140,
          child: FutureBuilder<List<FeedEvent>>(
            future: _simulation.fetchFeedWithFilters(
              author: widget.userName,
              limit: 5,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final highlights = snapshot.data!.take(3).toList();

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spacing16,
                ),
                itemCount: highlights.length,
                separatorBuilder: (_, __) => const SizedBox(
                  width: AppSpacing.spacing12,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 280,
                    child: FeedCard(
                      event: highlights[index],
                      compact: true,
                      showMetadata: false,
                      entryDelay: Duration(milliseconds: index * 50),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds recent activity header
  Widget _buildRecentActivityHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing16),
      child: Row(
        children: [
          Icon(
            Icons.history,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.spacing8),
          Text(
            'Actividad reciente',
            style: AppTypography.titleMedium.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds recent feed section with filtered events
  Widget _buildRecentFeedSection() {
    return SliverFillRemaining(
      child: FutureBuilder<List<FeedEvent>>(
        future: _simulation.fetchFeedWithFilters(
          author: widget.userName,
          sortAscending: false,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.spacing24),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing24),
                child: Text(
                  'No se pudo cargar la actividad',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }

          final events = snapshot.data!;

          if (events.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacing24),
                child: Text(
                  'Sin actividad reciente',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }

          return FeedList(
            initialEvents: events,
            showDateHeaders: true,
            compact: false,
            onRefresh: () => _simulation.fetchFeedWithFilters(
              author: widget.userName,
              sortAscending: false,
            ),
          );
        },
      ),
    );
  }
}
