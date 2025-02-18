import 'package:flutter/material.dart';

class WinBanner extends StatelessWidget {
  const WinBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.green.withValues(alpha: 0.2),
      child: Row(
        children: [
          const Icon(Icons.celebration, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            'Ура!!! Ты молодец!!!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.green,
                ),
          ),
        ],
      ),
    );
  }
}
