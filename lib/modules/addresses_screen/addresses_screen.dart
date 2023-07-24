import 'package:algad_infohub/modules/addresses_screen/addresses_details.dart';
import 'package:algad_infohub/modules/addresses_screen/cubit/addresses_cubit.dart';
import 'package:algad_infohub/modules/addresses_screen/cubit/addresses_states.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/components/my_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/search_widget.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(
          context,
        ),
        body: Column(
          children: [
            SearchWidget(
              onChanged: (val) {
                setState(
                  () {
                    name = val;
                  },
                );
              },
            ),
            buildMainWidget(size,),
          ],
        ),
      ),
    );
  }

  Widget buildMainWidget(size) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('myAddresses')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState ==
                ConnectionState.waiting)
                ? const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            )
                : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;
                if (name.isEmpty) {
                  return Container();
                }
                if (data['organizationName']
                    .toString()
                    .toLowerCase()
                    .contains(name.toLowerCase())) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                AddressesCubit(),
                            child: AddressesDetails(
                              address: data['addresses'],
                              name: data['organizationName'],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * .02,
                        horizontal: size.width * .01,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  data['organizationName'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width * .05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                              ),
                            ],
                          ),
                          Divider(color: mainColor,thickness: 1,),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
              itemCount: snapshots.data!.docs.length,
            );
          },
        ),
      ),
    ),
  );
}
