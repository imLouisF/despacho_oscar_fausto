import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';

/// Home screen - Main landing page
/// Displays welcome message and navigation cards for all sections
/// Includes bottom navigation bar for quick access to main sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Current selected index for bottom navigation
  int _selectedIndex = 0;

  // Dynamic titles for AppBar based on bottom navigation selection
  final List<String> _titles = [
    'Despacho Oscar Fausto',
    'Agenda',
    'Casos',
    'Comunicación',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar with dynamic title based on bottom navigation selection
      appBar: CustomAppBar(
        title: _titles[_selectedIndex],
      ),
      
      // Scrollable body
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            Text(
              'Bienvenido al Despacho Jurídico',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Subtitle
            Text(
              'Seleccione una sección para continuar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            
            // Grid of navigation cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Using CustomButton for consistent styling
                CustomButton(
                  icon: Icons.calendar_today,
                  label: 'Agenda',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.agenda),
                ),
                CustomButton(
                  icon: Icons.folder,
                  label: 'Casos',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.casos),
                ),
                CustomButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comunicación',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.comunicacion),
                ),
                CustomButton(
                  icon: Icons.description,
                  label: 'Formularios',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.formularios),
                ),
                CustomButton(
                  icon: Icons.draw,
                  label: 'Firma',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.firma),
                ),
                CustomButton(
                  icon: Icons.settings,
                  label: 'Configuración',
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                ),
              ],
            ),
          ],
        ),
      ),
      
      // Bottom navigation bar for quick access to main sections
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Casos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Comunicación',
          ),
        ],
      ),
    );
  }

  /// Handles bottom navigation bar item tap
  /// Navigates to the corresponding screen based on selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on selected index
    switch (index) {
      case 0:
        // Stay on home screen (already here)
        break;
      case 1:
        // Navigate to Agenda
        Navigator.pushNamed(context, AppRoutes.agenda);
        break;
      case 2:
        // Navigate to Casos
        Navigator.pushNamed(context, AppRoutes.casos);
        break;
      case 3:
        // Navigate to Comunicación
        Navigator.pushNamed(context, AppRoutes.comunicacion);
        break;
    }
  }

}
