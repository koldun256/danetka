import 'package:danetka/models/situation.dart';
import 'package:danetka/services/llm_service.dart';
import 'package:danetka/services/situation_service.dart';
import 'package:flutter/material.dart';

class QuestionAnswer {
  final String question;
  final Answer answer;

  QuestionAnswer(this.question, this.answer);
}

class GameState extends ChangeNotifier {
  Situation? _situation;
  bool _isLoading = false;
  bool _hasWon = false;
  final List<QuestionAnswer> _questions = [];

  Situation? get situation => _situation;
  bool get isLoading => _isLoading;
  bool get hasWon => _hasWon;
  List<QuestionAnswer> get questions => _questions;

  final SituationService _situationService = SituationService();
  final LLMService _llmService = LLMService();

  Future<void> loadNewSituation() async {
    _isLoading = true;
    notifyListeners();

    _situation = await _situationService.fetchRandomSituation();
    _isLoading = false;
    _hasWon = false;
    _questions.clear();
    notifyListeners();
  }

  Future<void> submitQuestion(String question) async {
    if (_hasWon || _situation == null) return;

    final answer =
        await _llmService.getAnswer(question, _situation!.explanation);

    _questions.add(QuestionAnswer(question, answer));
    notifyListeners();

    if (answer == Answer.WIN) {
      _hasWon = true;
      notifyListeners();
    }
  }
}
