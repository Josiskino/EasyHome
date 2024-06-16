import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:easyhome/src/features/authentification/services/dio.dart';
import 'package:easyhome/src/features/gestion_produits/models/categorie.dart';

class CategorieController with ChangeNotifier {
  List<Categorie> _categories = [];
  List<Categorie> get categories => _categories;

  Future<Dio.Response?> fetchCategories() async {
    try {
      // Requête GET vers l'API pour obtenir les données des catégories
      Dio.Response response = await dio().get('/V1/categories');
      if (response.statusCode == 200) {
        // Récupérer les données des catégories depuis la réponse
        Map<String, dynamic> responseData = response.data;

        // Assurez-vous que `responseData` contient la clé `categories`
        if (responseData.containsKey('categories')) {
          List<dynamic> categoriesData = responseData['categories'];

          // Traitez chaque catégorie dans la liste
          List<Categorie> categorieList = categoriesData.map((data) {
            return Categorie.fromJson(data);
          }).toList();

          // Mettre à jour la liste _categories avec les catégories récupérées
          updateCategories(categorieList); // Mise à jour des catégories

          // Informer les widgets écoutant que les catégories ont été mises à jour
          notifyListeners();
          return response;
        } else {
          print('La clé "categories" est introuvable dans la réponse.');
        }
      } else if (response.statusCode == 404) {
        print('Erreur 404: Ressource non trouvée');
      } else if (response.statusCode == 500) {
        print('Erreur 500: Erreur interne du serveur');
      } else {
        print('Erreur ${response.statusCode}');
      }
      return null; // Retourner null en cas d'erreur ou si la clé "categories" est absente
    } catch (e) {
      print('Erreur de connexion: $e');
      return null; // Retourner null en cas d'erreur
    }
  }

  void updateCategories(List<Categorie> newCategories) {
    _categories.clear();
    _categories.addAll(newCategories);
    notifyListeners(); // Informe les widgets écoutant du changement
  }
}
