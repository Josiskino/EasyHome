import 'package:easyhome/src/features/class_model/keep_quartier_name.dart';
import 'package:easyhome/src/features/gestion_produits/controllers/QuartierController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuartierList extends StatefulWidget {
  const QuartierList({Key? key}) : super(key: key);

  @override
  State<QuartierList> createState() => _QuartierListState();
}

class _QuartierListState extends State<QuartierList> {
  int selectedIndex = -1;

  int getIdFromQuartierName(String name) {
    final quartiers =
        Provider.of<QuartierController>(context, listen: false).quartier;
    final index =
        quartiers.indexWhere((quartier) => quartier.nomQuartier == name);
    if (index != -1) {
      return quartiers[index].id; // Récupérer l'ID du quartier trouvé
    }
    return -1; // Retourner une valeur par défaut si le quartier n'est pas trouvé
  }

  @override
  Widget build(BuildContext context) {
    final selectQuartier = Provider.of<SelectQuartier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Quartiers'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50.0), // Marge à gauche
        child: ListView.builder(
          itemCount: Provider.of<QuartierController>(context, listen: false)
              .quartier
              .length,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              // Ajouter le Divider entre les éléments
              return Divider();
            }
            final int newIndex = index ~/ 2;
            return InkWell(
              onTap: () {
                Provider.of<SelectQuartier>(context, listen: false)
                    .activeIndex = index;
                setState(() {
                  // selectedIndex = index;
                  // selectQuartier.activeIndex = newIndex;
                  // Provider.of<SelectQuartier>(context).quartierChoice =
                  //     Provider.of<QuartierController>(context, listen: false)
                  //         .quartiers[index]
                  //         .nomQuartier;
                });
                // Ajoutez ici le code pour utiliser le quartier sélectionné
                // Par exemple, appeler une fonction avec quartiers[newIndex]
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Provider.of<QuartierController>(context, listen: false)
                          .quartier[index]
                          .nomQuartier,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (selectedIndex == newIndex)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
