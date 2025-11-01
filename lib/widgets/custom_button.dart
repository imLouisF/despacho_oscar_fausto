import 'package:flutter/material.dart';

/// Custom button widget with consistent styling
/// Uses app's primary color and soft shadow for visual consistency
/// Supports both tap and long press interactions
/// 
/// Usage example:
/// ```dart
/// CustomButton(
///   icon: Icons.home,
///   label: 'Home',
///   onPressed: () => print('Tapped'),
///   onLongPress: () => print('Long pressed'),
///   isCompact: false,
/// )
/// ```
class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final bool isCompact;

  const CustomButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.onLongPress,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine sizes based on compact mode
    final double iconSize = isCompact ? 32 : 48;
    final double padding = isCompact ? 12 : 16;
    final double spacing = isCompact ? 8 : 12;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with primary color
              Icon(
                icon,
                size: iconSize,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: spacing),
              
              // Label text
              Text(
                label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isCompact ? 14 : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
