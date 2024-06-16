import 'package:easyhome/src/features/gestion_produits/models/categorie.dart';
import 'package:easyhome/src/features/gestion_produits/models/quartier.dart';
import 'package:easyhome/src/features/authentification/models/agent.dart';
import 'package:easyhome/src/features/gestion_produits/models/image.dart';

class Produit {
  int? produitId;
  String titre;
  int? nbreChambre;
  int? nbreSalon;
  int? nbreSalleDeBain;
  int? superficie;
  String? description;
  double? prix;
  String statut;
  String? etat;
  bool isPublic;
  DateTime? dateMiseEnLigne;
  int categorie_id;
  Categorie? categorie;
  Quartier? quartier;
  Agent? agent;
  int quartier_id;
  int agent_id;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Image>? images;

  Produit({
    this.produitId,
    required this.titre,
    this.nbreChambre,
    this.nbreSalon,
    this.nbreSalleDeBain,
    this.superficie,
    this.description,
    this.prix,
    required this.statut,
    required this.etat,
    required this.isPublic,
    this.dateMiseEnLigne,
    required this.categorie_id,
    this.agent,
    this.quartier,
    this.categorie,
    required this.quartier_id,
    required this.agent_id,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  // Méthode pour définir l'ID du produit pour chaque image associée à ce produit
  void setProductIdForImages() {
    images!.forEach((image) {
      image.produitId =
          this.produitId!; // Affecte l'ID du produit à chaque image
    });
  }

  // méthode pour mapper les données JSON en objet Produit
  factory Produit.fromJson(Map<String, dynamic> json) {
    List<Image> imagesList =
        []; // Crée une liste d'images associées à ce produit

    if (json['images'] != null) {
      List<dynamic> imagesData = json['images'];
      for (var imageData in imagesData) {
        Image image = Image.fromJson(imageData);
        print('object');
        image.produitId =
            json['id']; // Attribution de l'ID du produit à l'image
        imagesList.add(image);
      }
    }

    return Produit(
      produitId: json['id'],
      titre: json['titre'].toString(),
      nbreChambre: json['nbreChambre'],
      nbreSalon: json['nbreSalon'] != null ? json['nbreSalon'] as int : null,
      nbreSalleDeBain: json['nbreSalleDeBain'] != null
          ? json['nbreSalleDeBain'] as int
          : null,
      superficie: json['superficie'] != null ? json['superficie'] as int : null,
      description: json['description'].toString(),
      prix: double.parse(json['prix']),
      statut: json['statut'].toString(),
      etat: json['etat'].toString(),
      dateMiseEnLigne: json['dateMiseEnLigne'] != null
          ? DateTime.parse(json['dateMiseEnLigne'])
          : null,
      isPublic: json['isPublic'] == 0,
      categorie_id: json['categorie_id'],
      quartier_id: json['quartier_id'],
      agent_id: json['agent_id'],
      agent: Agent.fromJson(json['agent']),
      quartier: Quartier.fromJson(json['quartier']),
      categorie: Categorie.fromJson(json['categorie']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      //updatedAt: DateTime.parse(json['updatedAt']),
      //updatedAt: json['updatedAt'],
      /*images: List<Image>.from(
          json['images'].map((image) => Image.fromJson(image))),
      imageUrls: imageUrlList,*/
      images: imagesList,
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'id': produitId,
      'titre': titre,
      'nbreChambre': nbreChambre,
      'nbreSalon': nbreSalon,
      'nbreSalleDeBain': nbreSalleDeBain,
      'superficie': superficie,
      'description': description,
      'prix': prix,
      'statut': statut,
      'etat': etat,
      'dateMiseEnLigne': dateMiseEnLigne?.toIso8601String(),
      'isPublic': isPublic ? 0 : 1, // Conversion booléenne en entier
      'categorie_id': categorie_id,
      'quartier_id': quartier_id,
      'agent_id': agent_id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'images': images!.map((image) => image.toJson()).toList(),
    };
  }*/

  Map<String, dynamic> toJson() {
    /*List<Map<String, dynamic>> imagesData = images != null
        ? images!.map((image) => image.toJson()).toList()
        : []; // Convertir les images en données JSON*/
    List<Map<String, dynamic>> imagesData = [];
    return {
      'titre': titre,
      'nbreChambre': nbreChambre,
      'nbreSalon': nbreSalon,
      'nbreSalleDeBain': nbreSalleDeBain,
      'superficie': superficie,
      'description': description,
      'prix': prix,
      'statut': statut,
      'etat': etat,
      'isPublic': isPublic,
      'dateMiseEnLigne': dateMiseEnLigne?.toIso8601String(),
      'categorie_id': categorie_id,
      'quartier_id': quartier_id,
      'agent_id': agent_id,
      'images': imagesData, // Ajouter les données des images au JSON
    };
  }
}
