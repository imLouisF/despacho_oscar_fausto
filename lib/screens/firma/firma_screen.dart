import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';

/// Firma screen - Displays signature functionality with mock visual for demonstration
class FirmaScreen extends StatelessWidget {
  const FirmaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom AppBar
      appBar: const CustomAppBar(title: 'Firma'),
      
      // Centered content with signature area mock
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mock visual signature area
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Área de firma\n(demo visual)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Mock save signature button (UI-only, non-functional)
              ElevatedButton(
                onPressed: () {
                  // UI-only: No action for demo
                },
                child: const Text('Guardar firma'),
              ),
              const SizedBox(height: 16),
              
              // Back button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade600,
                ),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
