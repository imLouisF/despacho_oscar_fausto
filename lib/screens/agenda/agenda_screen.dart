import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/card_item.dart';

/// Agenda screen - Displays schedule and appointments with mock data for demonstration
class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  // Mock data for demonstration purposes (UI-only)
  static const List<Map<String, String>> mockAgenda = [
    {'titulo': 'Audiencia 15/11 - 10:00 AM', 'detalle': 'Caso 001 - Contrato laboral'},
    {'titulo': 'Reunión 17/11 - 4:00 PM', 'detalle': 'Cliente: Martínez & Co.'},
    {'titulo': 'Entrega de documento', 'detalle': 'Caso 003 - Registro de marca'},
    {'titulo': 'Llamada con cliente', 'detalle': 'Caso 004 - Asesoría legal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: const CustomAppBar(title: 'Agenda'),
      
      // List of appointments
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Appointments list
            Expanded(
              child: ListView.builder(
                itemCount: mockAgenda.length,
                itemBuilder: (context, index) {
                  final item = mockAgenda[index];
                  return CardItem(
                    leadingIcon: Icons.calendar_today,
                    iconColor: Theme.of(context).primaryColor,
                    title: item['titulo']!,
                    subtitle: item['detalle'],
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
