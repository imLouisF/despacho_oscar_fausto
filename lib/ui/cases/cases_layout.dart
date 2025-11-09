import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/theme.dart';

/// CasesLayout - Legal cases management screen
/// 
/// Design Goal: Mirror home feed's visual rhythm for UX consistency
/// 
/// Structure:
/// - Header with title and actions
/// - Search bar for filtering cases
/// - Grid/list of case cards (placeholder)
/// - FloatingActionButton for adding new cases
/// 
/// Data Integration Notes:
/// - Currently shows empty state placeholder
/// - Ready for Firestore collection or Hive box
/// - Will display CaseCard widgets when data is available
class CasesLayout extends StatelessWidget {
  const CasesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppMicroStyle.spaceM),
                child: const _CasesHeader(),
              ),
            ),
            
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMicroStyle.spaceM,
                  vertical: AppMicroStyle.spaceS,
                ),
                child: const _SearchField(hintText: 'Buscar caso'),
              ),
            ),
            
            // Content Area (Empty State Placeholder)
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.all(AppMicroStyle.spaceM),
                child: const _EmptyState(
                  icon: Icons.folder_open_outlined,
                  title: 'No hay casos registrados',
                  subtitle: 'Agrega tu primer caso usando el botón +',
                ),
              ),
            ),
          ],
        ),
      ),
      
      // FloatingActionButton for adding new case
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add case screen
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Header widget with title and action buttons
class _CasesHeader extends StatelessWidget {
  const _CasesHeader();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMicroStyle.defaultAnimationDuration,
      curve: AppMicroStyle.defaultCurve,
      padding: EdgeInsets.all(AppMicroStyle.spaceM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary.withValues(alpha: 0.05),
            AppTheme.secondary.withValues(alpha: 0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowSoft],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Casos',
                style: AppTypography.headlineMedium,
              ),
              SizedBox(height: AppMicroStyle.spaceXS),
              Text(
                'Gestiona tus casos legales',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
          IconButton(
            icon: Icon(AppMicroStyle.icons['mas']),
            onPressed: () {},
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}

/// Reusable search field component
class _SearchField extends StatelessWidget {
  final String hintText;

  const _SearchField({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowSoft],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: Colors.grey.shade400,
          ),
          prefixIcon: Icon(
            AppMicroStyle.icons['buscar'],
            color: Colors.grey.shade400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppMicroStyle.spaceM,
            vertical: AppMicroStyle.spaceM,
          ),
        ),
      ),
    );
  }
}

/// Empty state placeholder widget
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: AppMicroStyle.spaceL),
          Text(
            title,
            style: AppTypography.titleLarge.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceS),
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
