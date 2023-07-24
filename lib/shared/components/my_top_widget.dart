import 'package:flutter/material.dart';

class MyTopWidget extends StatelessWidget {
  final Color color;
  final String name;
  final String id;

  MyTopWidget({
    Key? key,
    required this.color,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomRight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * .05,
          vertical: size.height * .02,
        ),
        child: Hero(
          tag: id,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * .06,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}
