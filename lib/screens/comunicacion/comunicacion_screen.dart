import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/card_item.dart';

/// Comunicación screen - Displays messages and communications with mock data for demonstration
class ComunicacionScreen extends StatelessWidget {
  const ComunicacionScreen({super.key});

  // Mock visual data for UI-only demo
  static const List<Map<String, String>> mockMensajes = [
    {'titulo': 'Nuevo mensaje de Cliente 1', 'detalle': 'Revisión de contrato'},
    {'titulo': 'Recordatorio: Audiencia mañana', 'detalle': 'a las 10:00 AM'},
    {'titulo': 'Documento compartido', 'detalle': 'Contrato Final.pdf'},
    {'titulo': 'Cliente 2 respondió', 'detalle': 'a tu mensaje'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: const CustomAppBar(title: 'Comunicación'),
      
      // List of messages
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: ListView.builder(
                itemCount: mockMensajes.length,
                itemBuilder: (context, index) {
                  final mensaje = mockMensajes[index];
                  return CardItem(
                    leadingIcon: Icons.chat_bubble_outline,
                    iconColor: Theme.of(context).primaryColor,
                    title: mensaje['titulo']!,
                    subtitle: mensaje['detalle'],
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
