import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/theme.dart';

/// ProfileLayout - User profile and settings screen
/// 
/// Design Goal: Mirror home feed's visual rhythm for UX consistency
/// 
/// Structure:
/// - Gradient header with avatar
/// - User information
/// - Statistics row (active, won, pending cases)
/// - Action buttons (edit profile, logout)
/// - Settings list
/// 
/// Data Integration Notes:
/// - Currently shows mock user data
/// - Ready for Firebase Auth integration
/// - Will connect to user profile in Firestore
class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Gradient Header with Avatar
          const SliverToBoxAdapter(
            child: _ProfileHeader(),
          ),
          
          // Statistics Row
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppMicroStyle.spaceM),
              child: const _StatisticsRow(),
            ),
          ),
          
          // Action Buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMicroStyle.spaceM,
                vertical: AppMicroStyle.spaceS,
              ),
              child: const _ActionButtons(),
            ),
          ),
          
          // Settings Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppMicroStyle.spaceM),
              child: const _SettingsSection(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gradient profile header with avatar and user info
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + AppMicroStyle.spaceL,
        bottom: AppMicroStyle.spaceXL,
        left: AppMicroStyle.spaceM,
        right: AppMicroStyle.spaceM,
      ),
      decoration: BoxDecoration(
        gradient: AppTheme.deepPurpleGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppMicroStyle.radiusXLarge),
          bottomRight: Radius.circular(AppMicroStyle.radiusXLarge),
        ),
        boxShadow: const [AppMicroStyle.shadowMedium],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: const [AppMicroStyle.shadowDeep],
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 50,
                color: AppTheme.primary,
              ),
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceM),
          
          // Name
          Text(
            'Lic. María Pérez',
            style: AppTypography.headlineMedium.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceXS),
          
          // Specialty
          Text(
            'Abogada Corporativa',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceXS),
          
          // Email
          Text(
            'maria.perez@despacho.com',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// Statistics row showing case metrics
class _StatisticsRow extends StatelessWidget {
  const _StatisticsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            value: '12',
            label: 'Activos',
            color: Colors.blue,
          ),
        ),
        SizedBox(width: AppMicroStyle.spaceM),
        Expanded(
          child: _StatCard(
            value: '8',
            label: 'Ganados',
            color: Colors.green,
          ),
        ),
        SizedBox(width: AppMicroStyle.spaceM),
        Expanded(
          child: _StatCard(
            value: '3',
            label: 'Pendientes',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

/// Individual statistic card
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.displaySmall.copyWith(
              color: color,
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceXS),
          Text(
            label,
            style: AppTypography.labelSmall,
          ),
        ],
      ),
    );
  }
}

/// Action buttons for profile operations
class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(AppMicroStyle.spaceM),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppMicroStyle.radiusMedium),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(AppMicroStyle.icons['editar'], size: 20),
                SizedBox(width: AppMicroStyle.spaceS),
                Text('Editar perfil', style: AppTypography.labelMedium),
              ],
            ),
          ),
        ),
        SizedBox(width: AppMicroStyle.spaceM),
        OutlinedButton(
          onPressed: () {
            // TODO: Logout
          },
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(AppMicroStyle.spaceM),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppMicroStyle.radiusMedium),
            ),
            side: BorderSide(color: Colors.red.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                size: 20,
                color: Colors.red,
              ),
              SizedBox(width: AppMicroStyle.spaceS),
              Text(
                'Salir',
                style: AppTypography.labelMedium.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Settings section with option list
class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración',
          style: AppTypography.headlineSmall,
        ),
        SizedBox(height: AppMicroStyle.spaceM),
        
        _SettingItem(
          icon: Icons.notifications_outlined,
          title: 'Notificaciones',
          subtitle: 'Gestionar alertas y avisos',
          onTap: () {},
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        _SettingItem(
          icon: Icons.security_outlined,
          title: 'Privacidad',
          subtitle: 'Configuración de privacidad',
          onTap: () {},
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        _SettingItem(
          icon: Icons.help_outline,
          title: 'Ayuda y soporte',
          subtitle: 'Contacta con nosotros',
          onTap: () {},
        ),
        SizedBox(height: AppMicroStyle.spaceS),
        
        _SettingItem(
          icon: Icons.info_outline,
          title: 'Acerca de',
          subtitle: 'Versión 1.0.0',
          onTap: () {},
        ),
      ],
    );
  }
}

/// Individual setting item
class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusMedium),
        boxShadow: const [AppMicroStyle.shadowSoft],
        border: Border.all(
          color: AppMicroStyle.borderThin.color,
          width: AppMicroStyle.borderThin.width,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppMicroStyle.radiusSmall),
          ),
          child: Icon(
            icon,
            color: AppTheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: AppTypography.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.bodySmall,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }
}
