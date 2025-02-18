import 'package:flutter/material.dart';
import 'package:danetka/models/game_state.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatelessWidget {
  const WinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Ты победил!!!')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ситуация: ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.situation?.description ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Объяснение',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.situation?.explanation ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Играть снова'),
                onPressed: () {
                  state.loadNewSituation();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
