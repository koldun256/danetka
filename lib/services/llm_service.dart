enum Answer { YES, NO, DOESNTMATTER, WIN }

class LLMService {
  Future<Answer> getAnswer(String question, String explanation) async {
    await Future.delayed(const Duration(seconds: 1));
    if (question == "Сосал?") return Answer.WIN;
    return [
      Answer.YES,
      Answer.NO,
      Answer.DOESNTMATTER
    ][DateTime.now().millisecond % 3];
  }
}
