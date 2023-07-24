import 'package:flutter/material.dart';
import '../colors.dart';
import 'icon_broken.dart';

class MainWidget extends StatelessWidget {
  MainWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.onPressed,
  }) : super(key: key);

  String id;
  String title;
  String subTitle;
  String date;
  // MaterialPageRoute materialPageRoute;

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Hero(
        tag: id,
        child: Padding(
          padding: EdgeInsets.all(
            size.width * .01,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: size.width * .06,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: size.width * .05,
                    height: 1,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * .01,
                    horizontal: size.width * .3,
                  ),
                  child: const Divider(
                    thickness: 2,
                    color: mainColor,
                  ),
                ),
                myRow(
                  size,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myRow(size) => Row(
        children: [
          Icon(
            IconBroken.Calendar,
            color: mainColor,
            size: size.width * .05,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: size.width * .035,
              color: mainColor,
            ),
          ),
          const Spacer(),
          const Text(
            'اقرأ المزيد',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            IconBroken.Arrow___Left_2,
            size: 15,
            color: mainColor,
          ),
        ],
      );
}
