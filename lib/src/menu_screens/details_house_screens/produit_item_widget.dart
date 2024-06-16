import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProduitItem extends StatelessWidget {
  const ProduitItem({Key? key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        _buildItem(),
        _buildItem(),
        // Ajoute ici autant d'éléments que tu le souhaites
      ],
    );
  }

  Widget _buildItem() {
    return Container(
      //padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 25,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  child: Image.asset(
                    "assets/images/house2.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1 000 000 CFA",
                        style: TextStyle(
                          color: Colors.orange[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        'Villa à vendre',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 17,
                            color: Colors.grey[600],
                          ),
                          Text(
                            'Lomé, Togo',
                            style: GoogleFonts.lato(
                                fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      //Ce sizedBox est a revoir
                      SizedBox(
                        height: 16.4,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print('Cique sur modifier!');
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.grey[500],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Modifier',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {
                              print('Clique sur Vendu!');
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.grey[500],
                                  ),
                                  Text(
                                    'Vendu ?',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'BOOSTEZ',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 4,
              left: 5,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.orange[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Nouveau",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 5,
              child: GestureDetector(
                onTap: () {
                  // Action à effectuer lors du clic sur l'icône "love"
                },
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
