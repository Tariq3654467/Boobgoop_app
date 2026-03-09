import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A lightweight placeholder page for menu items that do not yet have a dedicated screen.
class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'This is a placeholder page for "$title".\n\nImplement the real screen here when ready.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
