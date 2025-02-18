class LLMService {
  Future<String> getAnswer(String question, String explanation) async {
    await Future.delayed(const Duration(seconds: 1));
    return ["Да", "Нет", "Не имеет значения"][DateTime.now().millisecond % 3];
  }
}
