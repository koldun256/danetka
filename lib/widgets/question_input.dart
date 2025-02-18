import 'package:flutter/material.dart';
import 'package:danetka/state/game_state.dart';
import 'package:provider/provider.dart';

class QuestionInput extends StatelessWidget {
  const QuestionInput({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameState>(context, listen: false);
    final controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Ask your question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (question) {
                state.submitQuestion(question);
                controller.clear();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final question = controller.text;
              if (question.isNotEmpty) {
                state.submitQuestion(question);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
