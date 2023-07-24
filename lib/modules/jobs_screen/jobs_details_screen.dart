import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/my_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';


class JobsDetailsScreen extends StatelessWidget {
  const JobsDetailsScreen({
    Key? key,
    required this.job, required this.id, required this.name,
  }) : super(key: key);

  final String name;
  final String job;
  final String id;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "رجوع",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: mainColor,
            elevation: 0,
          ),
          body: Column(
            children: [
              MyTopWidget(color: mainColor, name: name, id: id,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(size.width * .05),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      'images/oo.png',
                    ),
                    fit: BoxFit.cover,
                  )),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Linkify(
                        text: job,
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
      ),
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
