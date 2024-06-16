import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:easyhome/src/features/authentification/services/dio.dart';
import 'package:easyhome/src/features/gestion_produits/models/quartier.dart';

class QuartierController with ChangeNotifier {
  List<Quartier> _quartiers = [];
  List<Quartier> get quartier => _quartiers;

  Future<Dio.Response?> fetchNeighbourhood() async {
    try {
      // Requête GET vers l'API pour obtenir les données des quartiers
      Dio.Response response = await dio().get('/V1/quartiers');
      if (response.statusCode == 200) {
        // Récupérer les données des quartiers depuis la réponse
        Map<String, dynamic> responseData = response.data;

        // Assurez-vous que `responseData` contient la clé `produits`
        if (responseData.containsKey('quartiers')) {
          List<dynamic> quartiersData = responseData['quartiers'];

          // Traitez chaque produit dans la liste
          List<Quartier> quartierList = quartiersData.map((data) {
            return Quartier.fromJson(data);
          }).toList();

          // Mettre à jour la liste _produits avec les produits récupérés
          //_quartiers.clear();
          //_quartiers.addAll(quartierList);

          updateQuartiers(quartierList); // Mise à jour des quartiers

          // Informer les widgets écoutant que les produits ont été mis à jour
          notifyListeners();
          return response;
        } else {
          print('La clé "quartier" est introuvable dans la réponse.');
        }
      } else if (response.statusCode == 404) {
        print('Erreur 404: Ressource non trouvée');
      } else if (response.statusCode == 500) {
        print('Erreur 500: Erreur interne du serveur');
      } else {
        print('Erreur ${response.statusCode}');
      }
      return null; // Retourner null en cas d'erreur ou si la clé "quartier" est absente
    } catch (e) {
      print('Erreur de connexion: $e');
      return null; // Retourner null en cas d'erreur
    }
  }

  void updateQuartiers(List<Quartier> newQuartiers) {
    _quartiers.clear();
    _quartiers.addAll(newQuartiers);
    notifyListeners(); // Informe les widgets écoutant du changement
  }
}
