import 'package:flutter/material.dart';
import '../../core/theme/microstyle.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/theme.dart';

/// ChatLayout - Internal messaging screen
/// 
/// Design Goal: Mirror home feed's visual rhythm for UX consistency
/// 
/// Structure:
/// - Header with title and search
/// - List of chat preview cards
/// - Empty state when no conversations
/// - Status indicators per user
/// 
/// Data Integration Notes:
/// - Currently shows mock conversation data
/// - Ready for Firestore real-time chat
/// - Will integrate with chat packages or custom implementation
class ChatLayout extends StatelessWidget {
  const ChatLayout({super.key});

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
                child: const _ChatHeader(),
              ),
            ),
            
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMicroStyle.spaceM,
                  vertical: AppMicroStyle.spaceS,
                ),
                child: const _SearchField(),
              ),
            ),
            
            // Content: Conversations list
            // TODO: Toggle hasConversations to false to show empty state
            SliverPadding(
              padding: EdgeInsets.all(AppMicroStyle.spaceM),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _ChatPreviewCard(
                    name: 'Lic. Juan García',
                    lastMessage: 'Revisé el documento que enviaste...',
                    timestamp: 'Hace 5 min',
                    unreadCount: 2,
                    isOnline: true,
                  ),
                  SizedBox(height: AppMicroStyle.spaceS),
                  const _ChatPreviewCard(
                    name: 'María López',
                    lastMessage: 'Perfecto, nos vemos mañana',
                    timestamp: 'Hace 1 hora',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  SizedBox(height: AppMicroStyle.spaceS),
                  const _ChatPreviewCard(
                    name: 'Dr. Carlos Ruiz',
                    lastMessage: 'Te envío el informe actualizado',
                    timestamp: 'Ayer',
                    unreadCount: 1,
                    isOnline: true,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header widget with title and actions
class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

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
                'Chat',
                style: AppTypography.headlineMedium,
              ),
              SizedBox(height: AppMicroStyle.spaceXS),
              Text(
                'Mensajes internos del equipo',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
          IconButton(
            icon: Icon(AppMicroStyle.icons['mas']),
            onPressed: () {
              // TODO: Start new conversation
            },
            color: AppTheme.primary,
          ),
        ],
      ),
    );
  }
}

/// Search field for filtering conversations
class _SearchField extends StatelessWidget {
  const _SearchField();

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
          hintText: 'Buscar conversación',
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

/// Chat preview card with status indicator
class _ChatPreviewCard extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isOnline;

  const _ChatPreviewCard({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isOnline,
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
      child: Row(
        children: [
          // Avatar with online status
          Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.deepPurpleGradient,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: AppMicroStyle.spaceM),
          
          // Message content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: AppTypography.titleMedium,
                    ),
                    Text(
                      timestamp,
                      style: AppTypography.labelSmall,
                    ),
                  ],
                ),
                SizedBox(height: AppMicroStyle.spaceXS),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unreadCount > 0)
                      Container(
                        margin: EdgeInsets.only(left: AppMicroStyle.spaceS),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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

// Empty state removed - currently showing conversation list
// To implement empty state, wrap conversation list in conditional
// and show empty message when no conversations exist
