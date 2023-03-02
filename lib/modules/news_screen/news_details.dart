import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/conponents.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    Key? key,
    required this.news,
    required this.name,
  }) : super(key: key);

  final String name;
  final String news;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "رجوع",
                ),
                backgroundColor: newsColor,
                elevation: 0.0,
              ),
              body: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: newsColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                        vertical: size.height * .02,
                      ),
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .08,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(size.width * .05),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/oo.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Text(
                            news,
                            style: TextStyle(
                              fontSize: size.width * .05,
                              height: size.height * .0017,
                              fontWeight: FontWeight.bold,
                            ),
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
      },
    );
  }
}
