import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryButton(Icons.house, "Maison"),
          categoryButton(Icons.villa, "Villa"),
          categoryButton(Icons.apartment, "Appartement"),
          categoryButton(Icons.agriculture, "Ferme"),
          categoryButton(Icons.bedroom_parent, "Chambre"),
        ],
      ),
    );
  }
}

Widget categoryButton(IconData icon, String? text) {
  return Container(
    margin: const EdgeInsets.all(18.0),
    width: 90.0,
    height: 90.0,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade100),
    ),
    child: InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32.0,
            color: const Color(0xFF2972FF),
          ),
          Text("$text")
        ],
      ),
    ),
  );
}
