import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(obfuscate: true)
  static String OAUTH_TOKEN = _Env.OAUTH_TOKEN;

  @EnviedField()
  static String FOLDER_ID = _Env.FOLDER_ID;
}
