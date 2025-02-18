import 'package:danetka/models/game_state.dart';
import 'package:danetka/services/llm_service.dart';
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
                _getAnswerText(qa.answer).toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getAnswerText(Answer answer) {
    switch (answer) {
      case Answer.YES:
        return "Да";
      case Answer.NO:
        return "Нет";
      case Answer.DOESNTMATTER:
        return "Не имеет значения";
      case Answer.WIN:
        return "Победа";
    }
  }

  Color _getAnswerColor(Answer answer) {
    switch (answer) {
      case Answer.YES || Answer.WIN:
        return Colors.green;
      case Answer.NO:
        return Colors.red;
      case Answer.DOESNTMATTER:
        return Colors.blueGrey;
    }
  }
}
