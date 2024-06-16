import 'dart:io';
import 'package:easyhome/src/features/authentification/controllers/AgentController.dart';
import 'package:easyhome/src/features/class_model/keep_quartier_name.dart';
import 'package:easyhome/src/features/class_model/store_image.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/CategorieController.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/ProduitController.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/QuartierController.dart';
import 'package:easyhome/src/features/gestion_produits/models/produit.dart';

import 'package:flutter/material.dart';
import 'package:easyhome/src/menu_screens/quartierList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class FavoriScreen extends StatefulWidget {
  const FavoriScreen({Key? key}) : super(key: key);

  @override
  State<FavoriScreen> createState() => _FavoriScreenState();
}

class _FavoriScreenState extends State<FavoriScreen> {
  bool isVenteSelected = true; // Booléen pour suivre l'onglet sélectionné
  int type = 1; //Pour vérifier le bouton sélectionner
  int category = 0; // Initialisez à 0
  int _maxLength = 650; //Longeur max pour le champ description

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _nbreSalonController = TextEditingController();
  final TextEditingController _nbrChambreController = TextEditingController();
  final TextEditingController _nbrSalleDeBain = TextEditingController();
  final TextEditingController _surperficieController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _superfParcelleController =
      TextEditingController();
  final TextEditingController _quartierController = TextEditingController();

  @override
  void dispose() {
    _titreController.dispose();
    _nbreSalonController.dispose();
    _nbrChambreController.dispose();
    _nbrSalleDeBain.dispose();
    _descriptionController.dispose();
    _superfParcelleController.dispose();
    _surperficieController.dispose();
    _prixController.dispose();
    super.dispose();
  }

  //List<IconWidget> listWidgets = [];

  final SelectedImagesModel selectedImagesModel =
      SelectedImagesModel(); // Instance de la classe de modèle

  /*List<File> _selectedImages =
      []; */ // Créez une liste pour stocker les images sélectionnées

  // La fonction de rappel qui sera transmise à ClickableWidget
  void _onImageSelected(File selectedImage) {
    setState(() {
      print('Rechercher moi !!!!');
      /*_selectedImages
          .add(selectedImage);*/ // Ajoutez l'image sélectionnée à la liste
      Provider.of<SelectedImagesModel>(context, listen: false).addImage(
          Provider.of<SelectedImagesModel>(context, listen: false).activeIndex,
          selectedImage);

      //selectedImagesModel.images.add(selectedImage);
    });
  }

  @override
  void initState() {
    super.initState();

    // Récupérer les catégories depuis le controller au démarrage de l'écran
    final categorieController =
        Provider.of<CategorieController>(context, listen: false);
    categorieController
        .fetchCategories(); // Appeler la fonction pour récupérer les catégories

    /*setState(() {
      listWidgets.addAll([
        IconWidget(icon: Icons.home, name: "Villa", type: 1),
        IconWidget(icon: Icons.home, name: "Villa", type: 2),
        IconWidget(icon: Icons.home, name: "Villa", type: 3),
        IconWidget(icon: Icons.home, name: "Villa", type: 4),
        IconWidget(icon: Icons.home, name: "Villa", type: 5),
        IconWidget(icon: Icons.home, name: "Villa", type: 6),
        IconWidget(icon: Icons.home, name: "Villa", type: 7),
        IconWidget(icon: Icons.home, name: "Villa", type: 8)
      ]);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    List<IconWidget> listWidgets = []; // Déclaration de listWidgets

    //Dans ce cas j'utilise les widget pour envoyer dans le GridView
    List<IconData> categoryIcons = [
      FontAwesomeIcons.house, // Icône pour la catégorie 1
      FontAwesomeIcons.store,
      FontAwesomeIcons.building,
      Icons.business,
      Icons.apartment,
      FontAwesomeIcons.question,
      FontAwesomeIcons.seedling,
      FontAwesomeIcons.warehouse,
      FontAwesomeIcons.bed,
      FontAwesomeIcons.city,
    ];

    //int category = 0; // Initialisez la variable category à 0

    // Mettre à jour le contenu de listWidgets après la récupération des catégories
    // Crée la liste de widgets dynamiquement à partir des catégories récupérées
    final categorieController = Provider.of<CategorieController>(context);
    categorieController.categories.asMap().forEach((index, categorie) {
      IconData icon = categoryIcons.length > index
          ? categoryIcons[index]
          : Icons.error; // Icône par défaut si pas d'icône correspondante
      listWidgets.add(IconWidget(
        icon: icon,
        name: categorie.nomCategorie,
        type: categorie.id,
      ));
    });

    //double screenHeight = MediaQuery.of(context).size.height;

    Future<Produit> addProduct(String credsJson) async {
      dynamic jsonMap = json.decode(credsJson);

      // Assurez-vous que jsonMap est de type Map<String, dynamic>
      if (jsonMap is Map<String, dynamic>) {
        Produit produit = Produit.fromJson(jsonMap);
        print(produit);
        return produit;
      } else {
        throw FormatException("Le JSON fourni n'est pas au format attendu.");
      }
    }

    final QuartierController quartierController =
        Provider.of<QuartierController>(context, listen: false);

    print('ok Je suis avant le scaffold');

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Ajoutez des photos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            /*Divider(
            height: 1,
            color: Colors.black,
          ),*/
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GridView.count(
                cacheExtent: 9999,
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                    .map((e) => ClickableWidget(e == 1, isVenteSelected, e
                        // Transmission de la fonction de rappel
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Ajoutez plusieurs photos pour augmenter vos chances\n d\'être contacté',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Divider(
              thickness: 10,
              color: Colors.grey.shade200,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Plus d\'info sur votre bien',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            type = 1;
                          });
                        },
                        child: Container(
                          child: Text(
                            "Vente",
                            style: TextStyle(
                                color:
                                    type == 1 ? Colors.white : Colors.black87),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: type == 1 ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: type == 1
                                      ? Colors.white
                                      : Colors.black87)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            type = 2;
                          });
                        },
                        child: Container(
                          child: Text(
                            "Location",
                            style: TextStyle(
                                color:
                                    type == 2 ? Colors.white : Colors.black87),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: type == 2 ? Colors.orange : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: type == 2
                                      ? Colors.white
                                      : Colors.black87)),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GridView.count(
                shrinkWrap: true,
                cacheExtent: 9999,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: type == 1
                    ? listWidgets
                        .map((iconWidget) => GestureDetector(
                            onTap: () {
                              setState(() {
                                category = iconWidget.type;
                                print(category);
                              });
                            },
                            child: SalesWidget(iconWidget, category)))
                        .toList()
                    : listWidgets
                        .map((iconWidget) => GestureDetector(
                            onTap: () {
                              setState(() {
                                category = iconWidget.type;
                              });
                            },
                            child: SalesWidget(iconWidget, category)))
                        .toList(),
                crossAxisCount: 3,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Visibility(
              visible: category == 1 ||
                  category == 3 ||
                  category == 4 ||
                  category == 5 ||
                  category == 9 ||
                  category == 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nbreSalonController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                15), // Ajustement de la hauteur du TextFormField
                        hintText: 'Nombre de salon(s): ',
                        hintStyle:
                            TextStyle(fontSize: 14), // Taille du texte d'indice
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _nbrChambreController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                15), // Ajustement de la hauteur du TextFormField
                        hintText: 'Nombre de chambre(s): ',
                        hintStyle:
                            TextStyle(fontSize: 14), // Taille du texte d'indice
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _nbrSalleDeBain,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                15), // Ajustement de la hauteur du TextFormField
                        hintText:
                            'Nombres de salles de bain: ', // Texte d'indice (placeholder)
                        hintStyle: TextStyle(fontSize: 14),
                        isDense: true,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _surperficieController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                15), // Ajustement de la hauteur du TextFormField
                        hintText: 'Surface: ', // Texte d'indice (placeholder)
                        hintStyle: TextStyle(fontSize: 14),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: category == 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _superfParcelleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal:
                                15), // Ajustement de la hauteur du TextFormField
                        hintText:
                            'Superficie de la parcelle: ', // Texte d'indice (placeholder)
                        hintStyle: TextStyle(fontSize: 14),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 10,
              color: Colors.grey.shade200,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _titreController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal:
                              15), // Ajustement de la hauteur du TextFormField
                      hintText: 'Saisissez le titre de votre annonce ',
                      hintStyle:
                          TextStyle(fontSize: 14), // Taille du texte d'indice
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _prixController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal:
                              15), // Ajustement de la hauteur du TextFormField
                      hintText: 'Prix: ',
                      hintStyle:
                          TextStyle(fontSize: 14), // Taille du texte d'indice
                      isDense: true,
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$_maxLength/650',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 15,
                          ),
                          hintText:
                              'Donnez une description détaillée de votre article. \n N\'indiquez pas vos coordonnées (e-mail, \n téléphones, ...) dans la desription.',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _maxLength = 650 - value.length;
                          });
                        },
                        maxLines: null,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Au clic, ouvrir la page avec la liste des quartiers
                          await quartierController
                              .fetchNeighbourhood(); // Appeler la fonction pour récupérer les quartiers
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => QuartierList(),
                          ));
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _quartierController,
                            decoration: InputDecoration(
                              hintText: Provider.of<SelectQuartier>(context,
                                              listen: false)
                                          .activeIndex !=
                                      -1
                                  ? Provider.of<QuartierController>(context,
                                              listen: false)
                                          .quartier[Provider.of<SelectQuartier>(
                                            context,
                                          ).activeIndex]
                                          .nomQuartier ??
                                      'Veuillez choisir votre quartier'
                                  : 'Veuillez choisir votre quartier',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 9,
                                horizontal: 15,
                              ),

                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ), // Icône de liste déroulante à droite
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue:
                            Provider.of<AuthController>(context, listen: false)
                                .agent
                                .telephone, // Mettez votre numéro ici
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        readOnly: true,
                        initialValue:
                            Provider.of<AuthController>(context, listen: false)
                                .agent
                                .telephone, // Mettez votre numéro WhatsApp ici
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/icons/whatsapp_icone.png", // Insérez le chemin vers l'icône de WhatsApp
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print('Je suis dans le clic Enregistrer');

                          // Vérifier si aucune catégorie n'a été sélectionnée (reste à 0)
                          if (category == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Veuillez sélectionner une catégorie !"),
                              ),
                            );
                          } else {
                            // Récupération du modèle d'images sélectionnées
                            SelectedImagesModel selectedImagesModel =
                                Provider.of<SelectedImagesModel>(context,
                                    listen: false);
                            Map<String, dynamic> creds = {
                              'titre': _titreController.text,
                              'nbreSalon': int.parse(_nbreSalonController.text),
                              'nbreChambre':
                                  int.parse(_nbrChambreController.text),
                              'nbreSalleDeBain':
                                  int.parse(_nbrSalleDeBain.text),
                              'superficie':
                                  int.parse(_surperficieController.text),
                              'prix': double.parse(_prixController.text),
                              'description': _descriptionController.text,
                              'statut': 'disponible',
                              'etat': 'Nouveau',
                              'isPublic': false,
                              'categorie_id': category,
                              'quartier_id': 1,
                              /*'quartier_id': Provider.of<SelectQuartier>(
                                              context,
                                              listen: false)
                                          .activeIndex !=
                                      -1
                                  ? Provider.of<QuartierController>(context,
                                          listen: false)
                                      .quartier[Provider.of<SelectQuartier>(
                                        context,
                                      ).activeIndex]
                                      .id
                                  : "",*/
                              'agent_id': Provider.of<AuthController>(context,
                                      listen: false)
                                  .agent
                                  .id,
                              'images': selectedImagesModel.images
                                  .where((image) =>
                                      image != null) // Filtrer les valeurs null
                                  .map((image) => image!
                                      .path) // Obtenir les chemins des images restantes
                                  .toList(),
                            };

                            print(creds);

                            ProduitController produitController =
                                ProduitController();

                            int numberOfImages =
                                selectedImagesModel.images.length;
                            print('Nombre d\'images : $numberOfImages');

                            await produitController.submitFormDataAndImages(
                              creds,
                            );
                          }
                        },
                        child: Text('Enregistrer'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconWidget {
  IconData icon;
  String name;
  int type;

  IconWidget({
    required this.icon,
    required this.name,
    required this.type,
  });
}

class ClickableWidget extends StatefulWidget {
  const ClickableWidget(this.showText, this.isSelected, this.index,
      {super.key});

  final bool showText;
  final bool isSelected;
  final int index;

  //final Function(File) onImageSelected; // La fonction de rappel

  @override
  State<ClickableWidget> createState() => _ClickableWidgetState();
}

class _ClickableWidgetState extends State<ClickableWidget> {
  bool isSelected = false; // Définition de la variable isSelected ici
  File? image;

  @override
  Widget build(BuildContext context) {
    double size = 70;

    print('je suis dans le Clikable');

    return GestureDetector(
      onTap: () async {
        Provider.of<SelectedImagesModel>(context, listen: false).activeIndex =
            widget.index;

        // Ouvrir la galerie pour sélectionner une image
        // Utilisation de ImagePicker pour sélectionner une image
        final ImagePicker _picker = ImagePicker();
        _picker.pickImage(source: ImageSource.gallery).then((value) async {
          if (value != null) {
            var selectedImagesModel =
                Provider.of<SelectedImagesModel>(context, listen: false);

            setState(() {
              //image = File(value.path);
              File image = File(value.path);
              isSelected = true;
              Provider.of<SelectedImagesModel>(context, listen: false).addImage(
                  Provider.of<SelectedImagesModel>(context, listen: false)
                      .activeIndex,
                  image); // Définit isSelected à true lorsqu'une image est sélectionnée
            });
            selectedImagesModel.images
                .add(File(value.path)); // Ajout de l'image au modèle de données
          }
        });
      },
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 5),
            border:
                Border.all(color: Color.fromARGB(255, 182, 181, 181), width: 2),
            color: Colors.grey[300],
          ),
          //padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(left: 6.0, right: 6.0),
          child: Provider.of<SelectedImagesModel>(context)
                      .images[widget.index - 1] ==
                  null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ajoutez',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Icon(
                            Icons.add_a_photo,
                            size: 18,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: widget.showText
                          ? Container(
                              height: 12,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                    'Photo principale',
                                    style: TextStyle(
                                      fontSize: 6,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    Provider.of<SelectedImagesModel>(
                      context,
                    ).images[widget.index - 1]!,
                    fit: BoxFit.cover,
                  ),
                )),
    );
  }
}

// Widget pour la section Vente
class SalesWidget extends StatelessWidget {
  final IconWidget iconWidget;
  final int category;

  SalesWidget(this.iconWidget, this.category);

  @override
  Widget build(BuildContext context) {
    //var selectedImagesModel = Provider.of<SelectedImagesModel>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: iconWidget.type == category ? Colors.orange : Colors.grey[300],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icônes différentes pour chaque élément
          Icon(
            iconWidget.icon,
            size: 40,
            color: Color.fromARGB(220, 250, 245, 245),
            //color: Color.fromARGB(255, 101, 134, 156),
          ),
          SizedBox(height: 8),
          // Textes différents pour chaque élément
          Text(
            iconWidget.name,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 101, 134, 156)),
          ),
        ],
      ),
    );
  }
}
