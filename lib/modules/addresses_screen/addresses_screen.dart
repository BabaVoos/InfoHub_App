import 'package:algad_infohub/modules/addresses_screen/addresses_details.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:algad_infohub/shared/components/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/state.dart';

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
    return BlocProvider(
      create: (context) => InfoHubCubit(),
      child: BlocConsumer<InfoHubCubit, InfoHubState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(IconBroken.Arrow___Right_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                titleSpacing: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  'رجوع',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.orange,
                elevation: 0,
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
                    child: Container(
                      width: double.infinity,
                      height: size.height * .07,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(.7),
                          ),
                          hintText: 'ابحث',
                        ),
                        autofocus: false,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                ? Center(
                              child: CircularProgressIndicator(
                                color: questions,
                              ),
                            )
                                : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = snapshots.data!.docs[index]
                                    .data() as Map<String, dynamic>;
                                if (name.isEmpty) {
                                  return Container();
                                }
                                if (data['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                    name.toLowerCase())) {
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
                                }
                                return Container();
                              },
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
      ),
    );
  }
}
