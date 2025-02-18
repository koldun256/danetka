import 'package:danetka/models/situation.dart';

class SituationService {
  Future<Situation> fetchRandomSituation() async {
    return Situation(
        description:
            "Человек живёт в доме где все стены смотрят на юг. Он видит медведя.",
        explanation: "Дом на северном полюсе, поэтому медведь - полярный.");
  }
}
