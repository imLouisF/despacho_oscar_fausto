import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/card_item.dart';

/// Casos screen - Displays legal cases with mock data for demonstration
class CasosScreen extends StatelessWidget {
  const CasosScreen({super.key});

  // Mock data for demonstration purposes (UI-only)
  static const List<Map<String, String>> mockCasos = [
    {'titulo': 'Caso 001 - Contrato laboral', 'estado': 'En proceso'},
    {'titulo': 'Caso 002 - Demanda civil', 'estado': 'Finalizado'},
    {'titulo': 'Caso 003 - Registro de marca', 'estado': 'Pendiente'},
    {'titulo': 'Caso 004 - Asesoría legal', 'estado': 'En revisión'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: const CustomAppBar(title: 'Casos'),
      
      // List of cases
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Cases list
            Expanded(
              child: ListView.builder(
                itemCount: mockCasos.length,
                itemBuilder: (context, index) {
                  final caso = mockCasos[index];
                  return CardItem(
                    leadingIcon: Icons.folder,
                    iconColor: Theme.of(context).primaryColor,
                    title: caso['titulo']!,
                    subtitle: caso['estado'],
                    onTap: () {
                      // UI-only: No action for demo
                    },
                  );
                },
              ),
            ),
            
            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver al inicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
