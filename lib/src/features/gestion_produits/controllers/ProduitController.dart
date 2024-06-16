import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:easyhome/src/features/authentification/services/dio.dart';
import 'package:easyhome/src/features/gestion_produits/models/produit.dart';
//import 'package:easyhome/src/features/class_model/store_image.dart';

//import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class ProduitController with ChangeNotifier {
  List<Produit> _produits = [];
  List<Produit> get produits => _produits;

  Future<Dio.Response?> fetchProductWithImages() async {
    try {
      // Requête GET vers l'API pour obtenir les données des produits
      Dio.Response response = await dio().get('/V1/produits');

      if (response.statusCode == 200) {
        // Récupérer les données des produits depuis la réponse
        Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('produits')) {
          List<dynamic> produitsData = responseData['produits'];

          print(responseData);

          // Traitez chaque produit dans la liste
          List<Produit> produitsList = produitsData.map((data) {
            print('ok');
            return Produit.fromJson(data);
          }).toList();

          // Mettre à jour la liste _produits avec les produits récupérés
          _produits.clear();
          _produits.addAll(produitsList);

          // Informer les widgets écoutant que les produits ont été mis à jour
          notifyListeners();

          return response;
        } else {
          print('La clé "produits" est introuvable dans la réponse.');
        }
      } else {
        print('Erreur ${response.statusCode}');
      }
      print('Erreur produite');
      return null; // Retourner null en cas d'erreur ou si la clé "produits" est absente
    } catch (e, stackTrace) {
      print('Erreur de connexion: $e');
      print('StackTrace: $stackTrace');
      print('whoops');
      return null; // Retourner null en cas d'erreur
    }
  }

  Future<void> submitFormDataAndImages(
    Map<String, dynamic> creds,
    //SelectedImagesModel selectedImagesModel,
  ) async {
    //SelectedImagesModel selectedImagesModel = SelectedImagesModel();

    // Ajouter les données de formulaire au FormData
    FormData formData = FormData();
    formData.fields.addAll(creds.entries
        .map((entry) => MapEntry(entry.key, entry.value.toString())));

    // Récupération de la liste des images à partir de creds
    //List<String> imagesList = List<String>.from(creds['images']);

    if (creds['images'] != null && creds['images'] is List<String>) {
      List<String> imagesList = List<String>.from(creds['images']);
      print('nous voulons te trouver image');
      print(imagesList);

      for (var imagePath in imagesList) {
        File imageFile =
            File(imagePath); // Convertir chaque chemin d'accès en objet File
        String nomImage = imagePath.split('/').last; // Nom du fichier

        formData.files.add(MapEntry(
          'images[]', // Nom du champ dans le FormData (avec [] pour indiquer plusieurs fichiers)
          await MultipartFile.fromFile(imageFile.path, filename: nomImage),
        ));
      }
    } else {
      throw FormatException('Le contenu de creds[\'images\'] est invalide.');
      // Ou gérer l'erreur d'une manière appropriée à votre application
    }

    //formData.fields.add(MapEntry('produit', json.encode(creds)));

    // Ajouter les données de formulaire au FormData
    /*FormData formData = FormData.fromMap({
      'produit': creds,
      'images': images.map((image) => MultipartFile.fromBytes(
              image.bytes, // Remplace bytes par le nom de l'attribut où sont stockées les données de l'image
              filename: image.nomFichier, // Remplace nomFichier par le nom de fichier de l'image
            )).toList(),
    });*/

    /*
    for (int i = 0; i < imagesList.length; i++) {
      File? currentImage = imagesList[i];
      if (currentImage != null) {
        String fileName = 'image_$i.jpg'; // Nom du fichier pour chaque image
        formData.files.add(MapEntry(
          'images', // Nom du champ dans le FormData
          await MultipartFile.fromFile(currentImage.path, filename: fileName),
        ));
      }
    }*/

    try {
      // Faire la requête POST multipart avec les données de formulaire et les images
      Response response = await dio().post(
        '/V1/produits',
        data: formData,
      );

      // Vérifier la réponse du serveur
      if (response.statusCode == 200) {
        print('Requête réussie !');
      } else {
        print('Erreur lors de la requête : ${response.statusCode}');
      }

      // Gérer la réponse ici (affichage, redirection, etc.)
      print('Réponse: ${response.data}');
    } catch (e) {
      // Gérer les erreurs ici
      print('Erreur lors de l\'envoi : $e');
    }
  }

  /*Future<String> postProductWithImages(creds) async {
    try {
      Dio.Response response = await dio().post('/V1/produits', data: creds);

      if (response.statusCode == 200) {
        print(response.data);
        return "ok";
      } else {
        print('Erreur ${response.statusCode}');
        return "ko";
      }
    } catch (e) {
      print('Erreur lors de l\'envoi du produit : $e');
      return "koo";
    }
    return "ko";
  }*/

  /*Future<String> postProductWithImages(Map creds, List<XFile>? images) async {
    try {
      // Vérification des credentials
      if (creds.isEmpty) {
        print("Credentials vides");
        return "ko";
      } else if (creds.isNotEmpty) {
        Dio.FormData formData = Dio.FormData();

        // Ajouter les données du produit au FormData
        formData.fields.addAll([
          MapEntry('titre', creds['titre']),
          // Ajoute d'autres champs en fonction des données du formulaire
        ]);

        // Ajouter les images sélectionnées au FormData
        if (images != null && images.isNotEmpty) {
          for (int i = 0; i < images.length; i++) {
            formData.files.add(
              Dio.MultipartFile.fromFileSync(images[i].path,
                      filename: 'image_$i.jpg')
                  as MapEntry<String, Dio.MultipartFile>,
            );
          }
        }

        // Envoyer la requête POST avec le FormData contenant les données du produit et les images
        Dio.Response response =
            await dio().post('/V1/produits', data: formData);

        if (response.statusCode == 200) {
          // Traitement en cas de succès de la requête
          // Peut-être mettre à jour les produits ou effectuer d'autres actions
          return "ok";
        } else {
          print('Erreur ${response.statusCode}');
          return "ko";
        }
      }
    } catch (e) {
      print('Erreur lors de l\'envoi du produit : $e');
      return "koo";
    }
    return "ko";
  }*/

  /*
  //Cette Function est OPERATIONNEL
  // Méthode pour récupérer les produits depuis l'API
  Future<Dio.Response?> fetchProductWithImages() async {
    try {
      // Requête GET vers l'API pour obtenir les données des produits
      Dio.Response response = await dio().get('/V1/produits');

      if (response.statusCode == 200) {
        // Récupérer les données des produits depuis la réponse
        //var produitsData = response.data;

        // Effacer les produits existants avant de charger de nouveaux produits
        _produits.clear();

        print(response.data);

        // Récupérer les données des produits depuis la réponse
        List<dynamic> produitsData = response.data;

        // Mapper les données JSON en objets Produit et les ajouter à la liste
        produitsData.forEach((data) {
          Produit produit = Produit.fromJson(data);
          _produits.add(produit);
        });

        // Informer les widgets écoutant que les produits ont été mis à jour
        notifyListeners();

        return response;
      } else {
        print('Erreur ${response.statusCode}');
      }
      return response;
    } catch (e) {
      print('Erreur de connexion: $e');
    }
  }*/
}
