import 'package:danetka/state/game_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerHistory extends StatelessWidget {
  const AnswerHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<GameState>(context, listen: true).questions;

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final qa = questions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            title: Text(qa.question),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getAnswerColor(qa.answer),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                qa.answer.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getAnswerColor(String answer) {
    switch (answer.toLowerCase()) {
      case 'Да':
        return Colors.green;
      case 'Нет':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
