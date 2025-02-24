import 'dart:convert';
import 'dart:math';

import 'package:danetka/models/situation.dart';
import 'package:flutter/services.dart';

class SituationService {
  Future<Situation> fetchRandomSituation() async {
    String danetkiJsonString =
        await rootBundle.loadString('assets/danetki.json');

    List<dynamic> danetki = jsonDecode(danetkiJsonString)["danetki"];
    dynamic randomSituation = danetki[Random().nextInt(danetki.length)];

    return Situation(
        description: randomSituation["description"],
        explanation: randomSituation["explanation"]);
  }
}
