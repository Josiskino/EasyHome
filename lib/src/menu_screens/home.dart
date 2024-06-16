import 'package:flutter/material.dart';
import 'package:easyhome/src/features/gestion_produits/models/produit.dart';
import 'package:easyhome/src/menu_screens/suggestion_list.dart';
import 'package:easyhome/src/common_widget/search_field.dart';
import 'package:easyhome/src/common_widget/select_category.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:provider/provider.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/ProduitController.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  List<Produit> produits = [];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Produit> produits = [];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Appeler fetchProductWithImages lors de l'initialisation du widget
    // pour déclencher cet appel légèrement après la construction initiale
    Future.delayed(Duration.zero, () async {
      var produitController =
          Provider.of<ProduitController>(context, listen: false);
      Dio.Response? response = await produitController.fetchProductWithImages();

      if (response != null && response.statusCode == 200) {
        setState(() {
          produits =
              produitController.produits; // Met à jour la liste de produits
          print(produits);
          isLoading = false;
        });
      }
    });
    //readToken();
  }

  //Cette function sert a stoker le token recupérer lors de la connexion
  /*void readToken() async {
    String? token = await this.storage.read(key: 'token') as String?;
    if (token != null) {
      print(token);
    } else {
      print('La clé "token" n\'a pas été trouvée dans le stockage sécurisé.');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            Text(
              "Lomé, TOGO",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            // Utilisation de Center pour centrer le cercle de chargement
            child: isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  )
                : Column(
                    children: [
                      SearchField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 10,
                        color: Colors.white,
                      ),
                      SelectCategory(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 10,
                        color: Colors.white,
                      ),
                      SuggestionList("Nouveautée", produits),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
