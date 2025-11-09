import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/theme.dart';

/// HomeFeed - Main social-style home screen for the law firm
/// 
/// Design Philosophy: "Looks like a social feed, functions as a case dashboard"
/// 
/// Combines:
/// - Professional legal practice management
/// - Social feed UX for engagement
/// - Modular content cards for flexibility
/// 
/// Structure:
/// - Lawyer profile card (top)
/// - Featured highlights (horizontal scroll)
/// - Activity feed (vertical list)
/// 
/// Data Integration Notes:
/// Currently uses mock data. Ready for integration with:
/// - Firestore for cloud sync
/// - Hive for local storage
/// - Provider/Riverpod for state management
class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Glassmorphic AppBar with subtle blur
      extendBodyBehindAppBar: true,
      appBar: _buildGlassmorphicAppBar(context),
      
      // Main scrollable content with iOS-style bounce
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Padding for AppBar
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
          
          // Profile Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppMicroStyle.spaceM),
              child: const LawyerProfileCard(),
            ),
          ),
          
          // Featured Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMicroStyle.spaceM,
                vertical: AppMicroStyle.spaceS,
              ),
              child: const FeaturedSection(),
            ),
          ),
          
          // Activity Feed Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMicroStyle.spaceM,
                vertical: AppMicroStyle.spaceS,
              ),
              child: const ActivityFeed(),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds glassmorphic AppBar with blur effect
  PreferredSizeWidget _buildGlassmorphicAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AppBar(
            title: Text(
              'Inicio',
              style: AppTypography.headlineMedium.copyWith(
                color: AppTheme.primary,
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.white.withValues(alpha: 0.8),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(AppMicroStyle.icons['notificaciones']),
                onPressed: () {},
                color: AppTheme.primary,
              ),
              IconButton(
                icon: Icon(AppMicroStyle.icons['buscar']),
                onPressed: () {},
                color: AppTheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== Profile Section ====================

/// LawyerProfileCard - Top profile card with lawyer info
/// 
/// Displays:
/// - Avatar
/// - Name and status
/// - Light gradient background
/// - Subtle shadow
class LawyerProfileCard extends StatelessWidget {
  const LawyerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppMicroStyle.spaceM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary.withValues(alpha: 0.1),
            AppTheme.secondary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowSoft],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.deepPurpleGradient,
              boxShadow: const [AppMicroStyle.shadowSoft],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          SizedBox(width: AppMicroStyle.spaceM),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lic. María Pérez',
                  style: AppTypography.titleLarge,
                ),
                SizedBox(height: AppMicroStyle.spaceXS),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: AppMicroStyle.spaceXS),
                    Text(
                      'En línea',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== Featured Section ====================

/// FeaturedSection - Horizontal scrollable highlights
/// 
/// Displays important updates and announcements
/// Uses gradient cards for visual prominence
class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destacados del despacho',
          style: AppTypography.headlineSmall,
        ),
        SizedBox(height: AppMicroStyle.spaceM),
        
        // Horizontal scrolling cards
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              FeaturedCard(
                title: 'Nuevo caso\nganado',
                icon: Icons.check_circle_outline,
              ),
              FeaturedCard(
                title: 'Actualización\njurídica',
                icon: Icons.article_outlined,
              ),
              FeaturedCard(
                title: 'Recordatorio\nsemanal',
                icon: Icons.notifications_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// FeaturedCard - Individual featured item card
class FeaturedCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const FeaturedCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: AppMicroStyle.spaceM),
      padding: EdgeInsets.all(AppMicroStyle.spaceM),
      decoration: BoxDecoration(
        gradient: AppTheme.deepPurpleGradient,
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowMedium],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== Activity Feed Section ====================

/// ActivityFeed - Vertical list of recent activities
/// 
/// Displays:
/// - Case updates
/// - Reminders
/// - Notes and actions
/// 
/// Each card is interactive with subtle animations
class ActivityFeed extends StatelessWidget {
  const ActivityFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actividades recientes',
          style: AppTypography.headlineSmall,
        ),
        SizedBox(height: AppMicroStyle.spaceM),
        
        // Activity cards
        const ActivityCard(
          type: ActivityType.caseUpdate,
          title: 'Actualización Caso #001',
          subtitle: 'Hace 2 horas',
          description: 'Se agregó nueva documentación al expediente',
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        const ActivityCard(
          type: ActivityType.reminder,
          title: 'Audiencia programada',
          subtitle: 'Mañana a las 10:00 AM',
          description: 'Caso #003 - Tribunal Superior',
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        const ActivityCard(
          type: ActivityType.note,
          title: 'Nueva nota compartida',
          subtitle: 'Hace 5 horas',
          description: 'Lic. Juan García compartió un documento',
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        const ActivityCard(
          type: ActivityType.caseUpdate,
          title: 'Caso cerrado',
          subtitle: 'Ayer',
          description: 'Caso #002 finalizado exitosamente',
        ),
      ],
    );
  }
}

/// Activity card types for icon mapping
enum ActivityType {
  caseUpdate,
  reminder,
  note,
}

/// ActivityCard - Individual activity item
/// 
/// Interactive card with:
/// - Type-based icon
/// - Title and description
/// - Timestamp
/// - Action buttons
/// - Tap animation
class ActivityCard extends StatefulWidget {
  final ActivityType type;
  final String title;
  final String subtitle;
  final String description;

  const ActivityCard({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool _isPressed = false;

  IconData _getIcon() {
    switch (widget.type) {
      case ActivityType.caseUpdate:
        return Icons.folder_open_outlined;
      case ActivityType.reminder:
        return Icons.alarm;
      case ActivityType.note:
        return Icons.description_outlined;
    }
  }

  Color _getIconColor() {
    switch (widget.type) {
      case ActivityType.caseUpdate:
        return AppTheme.primary;
      case ActivityType.reminder:
        return Colors.orange;
      case ActivityType.note:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        // Handle tap - navigate to detail or show dialog
      },
      child: AnimatedScale(
        scale: _isPressed ? AppMicroStyle.tapScale : 1.0,
        duration: AppMicroStyle.fastAnimationDuration,
        curve: AppMicroStyle.defaultCurve,
        child: Container(
          padding: EdgeInsets.all(AppMicroStyle.spaceM),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppMicroStyle.radiusMedium),
            boxShadow: const [AppMicroStyle.shadowSoft],
            border: Border.all(
              color: AppMicroStyle.borderThin.color,
              width: AppMicroStyle.borderThin.width,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getIconColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppMicroStyle.radiusSmall),
                ),
                child: Icon(
                  _getIcon(),
                  color: _getIconColor(),
                  size: 20,
                ),
              ),
              SizedBox(width: AppMicroStyle.spaceM),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.titleMedium,
                    ),
                    SizedBox(height: AppMicroStyle.spaceXS),
                    Text(
                      widget.description,
                      style: AppTypography.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppMicroStyle.spaceXS),
                    Text(
                      widget.subtitle,
                      style: AppTypography.labelSmall,
                    ),
                  ],
                ),
              ),
              
              // Actions
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(height: AppMicroStyle.spaceXS),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
