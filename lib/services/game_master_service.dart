import 'package:danetka/models/situation.dart';
import 'package:danetka/services/gpt_api.dart';

enum Answer { YES, NO, DOESNTMATTER, WIN }

class GameMasterService {
  String _generateSystemPrompt(Situation situation) {
    return """Ты — ведущий в игре данетка. Я предоставлю тебе загадку и её разгадку. Твоя задача — отвечать на вопросы игрока только одним из следующих вариантов:

"Да" — если ответ на вопрос игрока однозначно утвердительный.

"Нет" — если ответ на вопрос игрока однозначно отрицательный.

"Не имеет значения" — если вопрос не связан с разгадкой или не влияет на решение.

"Загадка разгадана" — если игрок правильно назвал решение или объяснил ситуацию.

Ты должен строго следовать этим правилам. Не давай подсказок, не объясняй свои ответы и не отклоняйся от формата.

Загадка: ${situation.description}
Разгадка: ${situation.explanation}

Теперь жди вопросов от игрока и отвечай только в рамках указанных правил.""";
  }

  Future<Answer> getAnswer(Situation situation, String question) async {
    final String gptAns = await GptApi.prompt(
        systemPrompt: _generateSystemPrompt(situation),
        userPrompt: question,
        model: GptModels.LLama);

    print(gptAns);

    if (gptAns.toLowerCase().contains("загадка разгадана")) {
      return Answer.WIN;
    }

    if (gptAns.toLowerCase().contains("да")) {
      return Answer.YES;
    }

    if (gptAns.toLowerCase().contains("нет")) {
      return Answer.NO;
    }

    return Answer.DOESNTMATTER;
  }
}
