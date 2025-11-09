import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/theme.dart';

/// AgendaLayout - Calendar and scheduling screen
/// 
/// Design Goal: Mirror home feed's visual rhythm for UX consistency
/// 
/// Structure:
/// - Header with title and actions
/// - Today summary card
/// - Calendar placeholder
/// - Action button to view full calendar
/// 
/// Data Integration Notes:
/// - Currently shows placeholder data
/// - Ready for calendar events from Firestore
/// - Will integrate with calendar packages (table_calendar, etc.)
class AgendaLayout extends StatelessWidget {
  const AgendaLayout({super.key});

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
                child: const _AgendaHeader(),
              ),
            ),
            
            // Today Summary Card
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMicroStyle.spaceM,
                  vertical: AppMicroStyle.spaceS,
                ),
                child: const _TodaySummaryCard(),
              ),
            ),
            
            // Calendar Placeholder
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppMicroStyle.spaceM),
                child: const _CalendarPlaceholder(),
              ),
            ),
            
            // View Full Calendar Button
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppMicroStyle.spaceM),
                child: const _FullCalendarButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header widget with title and action buttons
class _AgendaHeader extends StatelessWidget {
  const _AgendaHeader();

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
                'Agenda',
                style: AppTypography.headlineMedium,
              ),
              SizedBox(height: AppMicroStyle.spaceXS),
              Text(
                'Tus eventos y reuniones',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
          IconButton(
            icon: Icon(AppMicroStyle.icons['mas']),
            onPressed: () {
              // TODO: Add new event
            },
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}

/// Today summary card showing today's events
class _TodaySummaryCard extends StatelessWidget {
  const _TodaySummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppMicroStyle.spaceL),
      decoration: BoxDecoration(
        gradient: AppTheme.deepPurpleGradient,
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowMedium],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.today_outlined,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: AppMicroStyle.spaceM),
              Text(
                'Hoy',
                style: AppTypography.headlineSmall.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: AppMicroStyle.spaceM),
          Text(
            'Tienes 3 reuniones programadas',
            style: AppTypography.titleMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceS),
          Text(
            'Próxima: Audiencia Caso #001 - 10:00 AM',
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

/// Calendar placeholder widget
class _CalendarPlaceholder extends StatelessWidget {
  const _CalendarPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(AppMicroStyle.spaceL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        boxShadow: const [AppMicroStyle.shadowSoft],
        border: Border.all(
          color: AppMicroStyle.borderThin.color,
          width: AppMicroStyle.borderThin.width,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: AppMicroStyle.spaceL),
          Text(
            'Vista de calendario',
            style: AppTypography.titleLarge.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: AppMicroStyle.spaceS),
          Text(
            'Aquí se mostrará el calendario mensual',
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

/// Full calendar action button
class _FullCalendarButton extends StatelessWidget {
  const _FullCalendarButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Navigate to full calendar view
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: AppMicroStyle.spaceL,
          vertical: AppMicroStyle.spaceM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMicroStyle.radiusLarge),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_view_month),
          SizedBox(width: AppMicroStyle.spaceS),
          Text(
            'Ver calendario completo',
            style: AppTypography.labelLarge,
          ),
        ],
      ),
    );
  }
}
