import 'package:algad_infohub/modules/addresses_screen/addresses_details.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AdminAddressesScreen extends StatelessWidget {

  CollectionReference jobsRef = FirebaseFirestore.instance.collection('myAddresses');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<InfoHubCubit, InfoHubState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'رجوع',
                style: TextStyle(fontSize: 22),
              ),
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('myAddresses')
                      .snapshots(),
                  builder: (context, snapshots) {
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BlocProvider(
                                      create: (context) =>
                                          InfoHubCubit(),
                                      child: AddressesDetails(
                                        address: data['addresses'],
                                        name: data['name'],
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data['name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width * .06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore
                                          .instance
                                          .runTransaction(
                                              (Transaction
                                          myTransaction) async {
                                            await myTransaction
                                                .delete((snapshots
                                                .data!
                                            as QuerySnapshot)
                                                .docs[index]
                                                .reference);
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color:
                                      adminColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 30,
                                  color: adminColor,
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            color: Colors.black,
                          ),
                      itemCount: snapshots.data!.docs.length,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
