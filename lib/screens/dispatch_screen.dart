import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DispatchScreen extends StatelessWidget {
  const DispatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispatch Management'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send_time_extension, size: 80, color: AppColors.accentOrange),
            const SizedBox(height: 16),
            const Text(
              'Assign loaded inventory to\ndrivers and fleet vehicles.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Load assignment workflow')));
              },
              icon: const Icon(Icons.assignment_ind),
              label: const Text('Assign Driver'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
