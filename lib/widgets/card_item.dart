import 'package:flutter/material.dart';

/// Reusable card component for displaying information panels or list items
/// Supports optional leading icon, title, subtitle, and trailing widget
/// Uses app's theme colors with rounded corners and subtle elevation
/// 
/// Usage example:
/// ```dart
/// CardItem(
///   leadingIcon: Icons.person,
///   title: 'John Doe',
///   subtitle: 'Attorney',
///   trailing: Icon(Icons.arrow_forward_ios, size: 16),
///   onTap: () => print('Card tapped'),
/// )
/// ```
class CardItem extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const CardItem({
    super.key,
    this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Leading icon (optional)
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  size: 32,
                  color: iconColor ?? Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 16),
              ],
              
              // Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    // Subtitle (optional)
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Trailing widget (optional)
              if (trailing != null) ...[
                const SizedBox(width: 12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}