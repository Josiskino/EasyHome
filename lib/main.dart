//import natif de Laravel
import 'package:easyhome/src/features/class_model/keep_quartier_name.dart';
import 'package:easyhome/src/features/class_model/store_image.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/CategorieController.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/QuartierController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import d'ajout pour l'authentification
import 'src/features/authentification/screens/login_page.dart';
import 'src/features/authentification/screens/register_page.dart';
//import 'src/features/main_menu/screens/main_menu.dart';

//import pour Le Notifier
import 'src/features/authentification/controllers/AgentController.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/ProduitController.dart';

//import d'ajout pour l'application Template
//import 'package:easyhome/src/features/main_menu/constants/contants.dart';
//import 'package:easyhome/src/features/main_menu/screens/details/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => ProduitController()),
        ChangeNotifierProvider(create: (context) => QuartierController()),
        ChangeNotifierProvider(create: (context) => SelectedImagesModel()),
        ChangeNotifierProvider(create: (context) => CategorieController()),
        ChangeNotifierProvider(create: (context) => SelectQuartier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => MyLogin(),
          'register': (context) => MyRegister(),
          //'home_screen': (context) => HomeScreen(),
        },
      ),
    ),
  );
}
