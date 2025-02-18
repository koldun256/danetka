import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:danetka/env.dart';

class IamToken {
  final DateTime _creationDate = DateTime.now();
  final String token;

  IamToken(this.token);
  bool expired() {
    return DateTime.now().difference(_creationDate) >= Duration(hours: 1);
  }
}

class IamTokenProvider {
  IamToken? _iamToken;

  Future<IamToken> _generateIamToken() async {
    final oauthToken = Env.OAUTH_TOKEN;

    final ans = await http.post(
        Uri.parse('https://iam.api.cloud.yandex.net/iam/v1/tokens'),
        body: jsonEncode(<String, String>{
          'yandexPassportOauthToken': oauthToken,
        }));

    return IamToken(jsonDecode(ans.body)['iamToken']);
  }

  Future<String> getIamToken() async {
    if (_iamToken == null || _iamToken!.expired()) {
      _iamToken = await _generateIamToken();
    }

    return _iamToken!.token;
  }
}

abstract class GptModels {
  static const String Lite = "yandexgpt-lite";
  static const String Pro = "yandexgpt";
  static const String LLama = "llama";
}

abstract class GptApi {
  static final IamTokenProvider _iamTokenProvider = IamTokenProvider();
  static double temperature = 0.6;
  static int maxTokens = 2000;

  static Future<String> prompt(
      {String? userPrompt,
      String? systemPrompt,
      String model = GptModels.Lite,
      double temperature = 0.6,
      int maxTokens = 2000}) async {
    final iamToken = await _iamTokenProvider.getIamToken();
    final folderId = Env.FOLDER_ID;
    final reqUrl =
        "https://llm.api.cloud.yandex.net/foundationModels/v1/completion";

    List<String> prompts = [];
    if (systemPrompt != null) {
      prompts.add(jsonEncode({"role": "system", "text": systemPrompt}));
    }
    if (userPrompt != null) {
      prompts.add(jsonEncode({"role": "user", "text": userPrompt}));
    }

    final reqBody = '''
    {
        "modelUri": "gpt://$folderId/$model",
        "completionOptions": {
            "stream": false,
            "temperature": $temperature,
            "maxTokens": $maxTokens
        },
        "messages": [${prompts.join(',')}]
    }
    ''';

    print("req body: $reqBody");

    final res = await http.post(Uri.parse(reqUrl), body: reqBody, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $iamToken",
      "x-folder-id": folderId
    });

    print("res body: ${utf8.decode(res.bodyBytes)}");
    return jsonDecode(utf8.decode(res.bodyBytes))["result"]["alternatives"][0]
        ["message"]["text"];
  }
}
