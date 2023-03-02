import 'package:algad_infohub/modules/addresses_screen/addresses_details.dart';
import 'package:algad_infohub/modules/addresses_screen/addresses_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:algad_infohub/shared/cubit/cubit.dart';
import 'package:algad_infohub/shared/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/conponents.dart';

class AddressesScreenTwo extends StatelessWidget {

  CollectionReference addressesRef = FirebaseFirestore.instance.collection('myAddresses');


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
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              titleSpacing: 0,
              title: Text(
                'رجوع',
                style: TextStyle(fontSize: 22,color: Colors.black),
              ),
              backgroundColor: Colors.orange,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, AddressesScreen(),);
                  },
                  icon: Icon(IconBroken.Search, color: Colors.black,),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * .05,
                    vertical: size.height * .02,
                  ),
                  alignment: Alignment.bottomRight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Text(
                    'عناوين',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * .08,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: addressesRef
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                              ConnectionState.waiting)
                              ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          )
                              : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = snapshots.data!.docs[index].data()
                                  as Map<String?, dynamic>;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => InfoHubCubit(),
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
                                            fontSize: size.width * .05,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) =>
                                Divider(
                              color: Colors.orange[300],
                              thickness: 1,
                            ),
                            itemCount: snapshots.data!.docs.length,
                          );
                        },
                      ),
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
}
