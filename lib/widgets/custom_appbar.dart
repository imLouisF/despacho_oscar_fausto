import 'package:flutter/material.dart';

/// Custom AppBar widget with consistent styling
/// Displays a dynamic title and uses the app's deep purple theme
/// 
/// Usage example:
/// ```dart
/// CustomAppBar(
///   title: 'My Screen',
///   actions: [
///     IconButton(
///       icon: Icon(Icons.search),
///       onPressed: () => print('Search'),
///     ),
///   ],
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      elevation: 2,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
