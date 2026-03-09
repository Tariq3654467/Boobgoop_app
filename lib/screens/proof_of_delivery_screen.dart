import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProofOfDeliveryScreen extends StatefulWidget {
  const ProofOfDeliveryScreen({super.key});

  @override
  State<ProofOfDeliveryScreen> createState() => _ProofOfDeliveryScreenState();
}

class _ProofOfDeliveryScreenState extends State<ProofOfDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proof of Delivery'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                'Upload delivery photo or signature to complete a delivery record.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Camera integration pending')));
                },
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Capture POD'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
