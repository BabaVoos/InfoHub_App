import 'cubit/news_cubit.dart';
import 'cubit/news_states.dart';
import '../../shared/colors.dart';
import '../../shared/components/my_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    Key? key,
    required this.news,
    required this.name,
    required this.id,
  }) : super(key: key);

  final String name;
  final String news;
  final String id;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "رجوع",
              ),
              backgroundColor: mainColor,
              elevation: 0.0,
            ),
            body: Column(
              children: [
                MyTopWidget(
                  color: mainColor,
                  name: name,
                  id: id,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(size.width * .05),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'images/oo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Linkify(
                          text: news,
                          style: TextStyle(
                            fontSize: size.width * .05,
                            color: Colors.black,
                            height: size.height * .0015,
                          ),
                          onOpen: _onOpen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await launch(link.url)) {
      await canLaunch(link.url);
    } else {
      print('ayaaa');
    }
  }
}
