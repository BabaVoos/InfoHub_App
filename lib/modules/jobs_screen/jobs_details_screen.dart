import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobsDetailsScreen extends StatelessWidget {
  const JobsDetailsScreen({
    Key? key,
    required this.job,
  }) : super(key: key);

  final String job;

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
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: jobsColor,
                elevation: 0,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(size.width * .05),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'images/oo.png',
                        ),
                        fit: BoxFit.cover,
                      )),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Text(
                            job,
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
