import 'package:algad_infohub/modules/addresses_screen/cubit/addresses_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/addresses_screen/addresses_details.dart';
import '../colors.dart';

class MyAddressWidget extends StatelessWidget {

  CollectionReference addressesRef = FirebaseFirestore.instance.collection('myAddresses');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: addressesRef.orderBy('publishDate',descending: true,)
                .snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState ==
                  ConnectionState.waiting)
                  ? const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              )
                  : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index].data()
                  as Map<String, dynamic>;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddressesCubit(),
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
                      child: Row(
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
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      color: mainColor,
                      thickness: 1,
                    ),
                itemCount: snapshots.data!.docs.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
