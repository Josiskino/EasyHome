import 'package:easyhome/src/common_widget/house_card.dart';
import 'package:flutter/material.dart';
import 'package:easyhome/src/features/gestion_produits/models/produit.dart';
//import 'package:easyhome/src/menu_common_widget/house_card.dart';

class SuggestionList extends StatefulWidget {
  SuggestionList(this.title, this.produits, {super.key});

  final String title;
  final List<Produit> produits;

  @override
  State<SuggestionList> createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text("Tout afficher"))
            ],
          ),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) =>
                  ItemCard(widget.produits[index], () {}),
            ),
          )
        ],
      ),
    );
  }
}
