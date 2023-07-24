import '../../shared/colors.dart';
import '../../shared/components/news_item.dart';
import 'package:flutter/material.dart';
import '../../shared/components/conponents.dart';
import '../../shared/components/icon_broken.dart';
import 'news_screen_two.dart';

class NewNewsScreen extends StatelessWidget {
  const NewNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: CircleAvatar(
          backgroundColor: mainColor,
          radius: 25,
          child: IconButton(
            onPressed: () {
              navigateTo(
                context,
                const NewsScreenTwo(),
              );
            },
            icon: const Icon(
              IconBroken.Search,
            ),
          ),
        ),
        body: Column(
          children: [
            NewsItem(),
          ],
        ),
      ),
    );
  }
}