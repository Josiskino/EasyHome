import 'package:easyhome/src/features/authentification/controllers/AgentController.dart';
import 'package:easyhome/src/menu_screens/account_details_update.dart';
import 'package:easyhome/src/menu_screens/details_house_screens/produit_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int type = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue.shade900, // Couleur bleue sombre pour l'AppBar
        title: Text(
          'Votre compte',
          style: TextStyle(color: Colors.white), // Couleur du texte en blanc
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Icône en blanc
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white), // Icône en blanc
            onPressed: () {
              // Naviguer vers la page AccountDetail lors du clic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailsAccount()),
              );
            },
          ),
        ],
        iconTheme:
            IconThemeData(color: Colors.white), // Couleur des icônes en blanc
      ),
      body: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 100,
                height: 150,
                padding: EdgeInsets.only(left: 10.5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 197, 233, 243)),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromARGB(103, 224, 224, 224),
                ), //A revoir Après

                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors
                            .blue.shade200, // Fond bleu pâle pour le cercle
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white, // Icône blanche
                          size: 60,
                        ),
                      ),
                    ),
                    SizedBox(
                        width:
                            35), // Espacement entre le cercle et le reste du contenu
                    // Autres widgets dans le conteneur
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                        ),
                        Text(Provider.of<AuthController>(context, listen: false)
                            .agent
                            .nomAgent),
                        Text(Provider.of<AuthController>(context, listen: false)
                            .agent
                            .prenomAgent),
                        Text('Lomé, Togo'),
                        Text('Membre depuis 1 an'),
                      ],
                    )
                  ],
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
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: 35,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 197, 233, 243)),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(103, 224, 224, 224),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(9.0),
                    ),
                    Text(
                        'Vendez plus vite et gagner plus \n grace a nos abonnements'),
                  ],
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
            TabBar(
              controller: _tabController,
              indicatorColor: Color.fromARGB(
                  255, 245, 167, 66), // Couleur de la barre de défilement
              labelColor:
                  Colors.lightBlueAccent, // Couleur du texte de l'onglet actif
              unselectedLabelColor: Color.fromARGB(226, 159, 205, 240),
              tabs: [
                Tab(text: 'Produits'),
                Tab(text: 'Boots'),
                Tab(text: 'Achats'),
              ], // Couleur du texte de l'onglet non actif
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              child: TabBarView(controller: _tabController, children: [
                // Contenu pour l'onglet 1
                Container(
                  child: Padding(
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
                                  "En vente",
                                  style: TextStyle(
                                      color: type == 1
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: type == 1
                                        ? Colors.orange
                                        : Colors.white,
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
                                  "En location",
                                  style: TextStyle(
                                      color: type == 2
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: type == 2
                                        ? Colors.orange
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: type == 2
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
                                  type = 3;
                                });
                              },
                              child: Container(
                                child: Text(
                                  "Vendues",
                                  style: TextStyle(
                                      color: type == 3
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: type == 3
                                        ? Colors.orange
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: type == 3
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
                                  type = 4;
                                });
                              },
                              child: Container(
                                child: Text(
                                  "Louées",
                                  style: TextStyle(
                                      color: type == 4
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: type == 4
                                        ? Colors.orange
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: type == 4
                                            ? Colors.white
                                            : Colors.black87)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            //child: GridView.count(crossAxisCount: crossAxisCount),
                          ),
                        ],
                      )),
                ),
                // Contenu pour l'onglet 2
                Center(
                  child: Text(
                    'Contenu Onglet 2',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // Contenu pour l'onglet 3
                Center(
                  child: Text(
                    'Contenu Onglet 3',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            )
          ],
        ),
      ), // Votre contenu ici
    );
  }
}
