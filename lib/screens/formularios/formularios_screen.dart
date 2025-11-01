import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/card_item.dart';

/// Formularios screen - Displays forms and documents with mock data for demonstration
class FormulariosScreen extends StatelessWidget {
  const FormulariosScreen({super.key});

  // Mock visual data for UI-only demo
  static const List<Map<String, String>> mockFormularios = [
    {'titulo': 'Formulario de ingreso de caso', 'detalle': 'Nuevo caso legal'},
    {'titulo': 'Registro de cliente', 'detalle': 'Datos personales y contacto'},
    {'titulo': 'Solicitud de documento', 'detalle': 'Requerimiento de archivos'},
    {'titulo': 'Evaluación de servicio', 'detalle': 'Opinión del cliente'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: const CustomAppBar(title: 'Formularios'),
      
      // List of forms
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Forms list
            Expanded(
              child: ListView.builder(
                itemCount: mockFormularios.length,
                itemBuilder: (context, index) {
                  final formulario = mockFormularios[index];
                  return CardItem(
                    leadingIcon: Icons.description_outlined,
                    iconColor: Theme.of(context).primaryColor,
                    title: formulario['titulo']!,
                    subtitle: formulario['detalle'],
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
