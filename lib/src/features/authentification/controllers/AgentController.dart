import 'package:easyhome/src/features/main_menu/screens/details/home/home_screen.dart';

import '../services/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/agent.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController with ChangeNotifier {
  bool _isloggedIn = false;
  late Agent _agent;
  late String _token;
  final storage = new FlutterSecureStorage();

  bool get authenticated => _isloggedIn;
  Agent get agent => _agent;

  Future<String> login({required Map creds}) async {
    print(creds);

    // Vérification des credentials
    if (creds.isEmpty) {
      print("Credentials vides");
      return "ko";
    } else if (creds.isNotEmpty) {
      try {
        Dio.Response response =
            await dio().post('/V1/agents/login', data: creds);
        String token = response.data['token'];
        Dio.Response tokenResponse = await tryToken(token: token);
        print(tokenResponse);
        // Utilisez tokenResponse ou faites d'autres actions en fonction de la réponse
        if (tokenResponse.statusCode == 200) {
          print("tokenResponse 200");
          return "ok";
        } else if (tokenResponse.statusCode != 200) {
          print("tokenResponse 987");
          return "ko";
        }
      } catch (e) {
        print(e);
        return "koo";
      }
    }
    print("666");
    return "ok";
  }

  Future<Dio.Response> tryToken({required String token}) async {
    if (token.isNotEmpty) {
      try {
        Dio.Response response = await dio().get('/V1/agent',
            options: Dio.Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            }));

        if (response.statusCode == 200) {
          print(response.data.toString());
          this._isloggedIn = true;
          this._agent = Agent.fromJson(response.data);
          this.storeToken(token: token);
          notifyListeners();
          print(_agent);
          return response;
        }
      } catch (e) {
        print("Erreur lors de la récupération des données utilisateur : $e");
      }
    } else {
      print("Token vide");
    }

    // Si la requête échoue ou le token est vide, renvoyer une réponse vide ou une autre valeur pour indiquer l'échec
    return Dio.Response(
        requestOptions: Dio.RequestOptions(path: ''), statusCode: 400);
  }

  Future<String> registerAgent(
      {required Map<String, dynamic> agentData}) async {
    print(agentData);

    if (agentData.isEmpty) {
      print("agentData est vide : $agentData");
      return "ko";
    } else {
      try {
        Dio.Response response = await dio().post('/V1/agents', data: agentData);
        print(response.data);

        if (response.statusCode == 200) {
          // L'enregistrement a réussi
          return "ok";
        } else {
          // L'enregistrement a échoué
          return "ko";
        }
      } catch (e) {
        // Une erreur s'est produite lors de la requête
        print(e);
        return "koo";
      }
    }
  }

  void storeToken({required String token}) async {
    this.storage.write(key: 'token', value: null);
  }

  void logout(Map creds) {
    _isloggedIn = false;
    notifyListeners();
  }
}
