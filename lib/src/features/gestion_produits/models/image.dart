import 'package:easyhome/src/constants/constants.dart';

class Image {
  int? imageId;
  //String nomImage;
  String cheminImage;
  DateTime createdAt;
  DateTime updatedAt;
  int produitId;

  Image({
    required this.imageId,
    required this.cheminImage,
    //required this.nomImage,
    required this.createdAt,
    required this.updatedAt,
    required this.produitId,
  });

  String getUrlComplete(String baseUrl) {
    return baseUrl + cheminImage;
  }

  // Méthode pour définir l'ID du produit dans un objet Image
  void setProductIdForImage(Image image, int productId) {
    image.produitId = productId;
  }

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      imageId: json['id'],
      //nomImage: json['nomImage'],
      cheminImage: baseUrl + json['cheminImage'],
      //createdAt: json['createdAt'],
      //updatedAt: json['updatedAt'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      produitId: json['pivot']['produit_id'],
    );
  }
}
