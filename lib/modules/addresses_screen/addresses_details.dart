import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressesDetails extends StatelessWidget {
  const AddressesDetails({
    Key? key,
    required this.address,
    required this.name,
  }) : super(key: key);

  final String address;
  final String name;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(IconBroken.Arrow___Right_2),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          title: const Text(
            'رجوع',
            style: TextStyle(fontSize: 22,color: Colors.black),
          ),
          backgroundColor: Colors.grey[300],

          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(size.width * .035),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                       name,
                        style: TextStyle(
                          color: mainColor,
                          fontSize: size.width * .06,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Divider(
                        color: mainColor,
                      ),
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor,),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * .03),
                          child: Linkify(
                            text: address,
                            style: TextStyle(
                              fontSize: size.width * .050,
                              fontWeight: FontWeight.w500,
                            ),
                            onOpen: _onOpen,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
              ],
            ),
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
