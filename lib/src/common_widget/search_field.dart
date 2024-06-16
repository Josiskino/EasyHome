import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius:
            BorderRadius.circular(50.0), // Adjust the radius as needed
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(50.0), // Adjust the radius as needed
            borderSide: BorderSide.none,
          ),
          hintText: "Rechercher sur EasyHome ...",
          prefixIcon: const Icon(CupertinoIcons.search),
          suffixIcon: const Icon(Icons.filter_alt_outlined),
        ),
      ),
    );
  }
}
