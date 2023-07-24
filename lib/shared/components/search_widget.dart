import 'package:flutter/material.dart';

import '../colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, required this.onChanged}) : super(key: key);

  final void Function(String,)? onChanged;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .05,
        vertical: size.height * .02,
      ),
      alignment: Alignment.bottomRight,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: mainColor,
      ),
      child: Container(
        width: double.infinity,
        height: size.height * .07,
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(.7),
            ),
            hintText: 'ابحث',
            hintStyle: TextStyle(color: Colors.white,),
          ),
          autofocus: false,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
