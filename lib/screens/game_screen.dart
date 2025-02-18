import 'package:danetka/models/game_state.dart';
import 'package:danetka/screens/win_screen.dart';
import 'package:danetka/widgets/answer_history.dart';
import 'package:danetka/widgets/question_input.dart';
import 'package:danetka/widgets/situation_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = Provider.of<GameState>(context, listen: false);
      state.loadNewSituation();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<GameState>(context).hasWon) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WinScreen(),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('ДаНетКа')),
      body: Consumer<GameState>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SituationDisplay(description: state.situation?.description ?? ''),
              const Expanded(child: AnswerHistory()),
              const QuestionInput(),
            ],
          );
        },
      ),
    );
  }
}
