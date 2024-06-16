import 'package:easyhome/src/features/gestion_produits/models/produit.dart';
import 'package:flutter/material.dart';

//import pour utiliser le service Provider
import 'package:easyhome/src/features/gestion_produits/controllers/ProduitController.dart';
import 'package:provider/provider.dart';

import 'package:easyhome/src/menu_screens/suggestion_list.dart';

class ItemCard extends StatefulWidget {
  ItemCard(this.produit, this.onTap, {super.key});
  final Produit produit;
  final Function()? onTap;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.4,
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                      //Voici la prtie ou on fait appel a l'image
                      image:
                          NetworkImage(widget.produit.images![0].cheminImage),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                widget.produit.categorie!.nomCategorie,
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.produit.titre,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  Text(
                    widget.produit.quartier!.nomQuartier,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.0,
                        color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${widget.produit.prix!.toInt()} FCFA /Mois",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // IconButton(onPressed: () {}, icon: icon)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
