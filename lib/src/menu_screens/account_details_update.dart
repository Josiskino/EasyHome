import 'package:easyhome/src/features/authentification/controllers/AgentController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsAccount extends StatefulWidget {
  const DetailsAccount({Key? key}) : super(key: key);

  @override
  State<DetailsAccount> createState() => _DetailsAccountState();
}

class _DetailsAccountState extends State<DetailsAccount> {
  bool isMaleSelected = false;
  bool isFemaleSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Couleur de fond de l'AppBar en blanc
        title: Text(
          'Modifier mon profil', // Texte de l'AppBar
          style: TextStyle(color: Colors.black), // Couleur du texte en noir
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, // Icône de flèche de retour
            color: Colors.black, // Couleur de l'icône en noir
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Action lors du clic sur la flèche de retour
          },
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 19.0,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Couleur du cercle
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white, // Couleur de l'icône
                        ),
                      ),
                    ),
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300], // Couleur du petit cercle
                        ),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Color.fromARGB(
                                255, 241, 161, 12), // Couleur de l'icône
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Divider(
            thickness: 10,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 25)),
                  Container(
                    child: Text(
                      'Nom',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal:
                            15), // Ajustement de la hauteur du TextFormField
                    hintText:
                        Provider.of<AuthController>(context, listen: false)
                            .agent
                            .nomAgent, // Texte d'indice (placeholder)
                    hintStyle: TextStyle(fontSize: 14),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 25)),
                  Container(
                    child: Text(
                      'Prénom(s)',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal:
                            15), // Ajustement de la hauteur du TextFormField
                    hintText:
                        Provider.of<AuthController>(context, listen: false)
                            .agent
                            .prenomAgent, // Texte d'indice (placeholder)
                    hintStyle: TextStyle(fontSize: 14),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            thickness: 10,
            color: Colors.grey.shade200,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Genre',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              /*Container(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          child: Text("Homme"),
                        ),
                      )),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
