import 'package:algad_infohub/models/addresses.dart';
import 'package:algad_infohub/modules/addresses_screen/cubit/addresses_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Authintication/helpers/my_easyloading.dart';
import '../../../shared/constants/const.dart';

class AddressesCubit extends Cubit<AddressesStates> {
  AddressesCubit()
      : super(
          AddressesInitialStates(),
        );

  static AddressesCubit get(context) => BlocProvider.of(
        context,
      );

  void addressCreate({
    required String addresses,
    required String organizationName,
  }) async {
    final docUid = FirebaseFirestore.instance
        .collection(
          "myAddresses",
        )
        .doc();

    Addresses model = Addresses(
      id: docUid.id,
      addresses: addresses,
      organizationName: organizationName,
      publishDate: Timestamp.now(),
    );

    await docUid.set(model.toJson()).then((value) {
      SharedFunctions.sendNotification(
        title: model.organizationName,
        body: model.addresses,
      );
      emit(AddAddressesSuccessState());
    }).catchError((error) {
      emit(AddAddressesErrorState(error.toString()));
    });
  }

  void addressDelete({
    required String id,
  }) {
    FirebaseFirestore.instance
        .collection('myAddresses')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteAddressesSuccessState());
    }).catchError((error) {
      emit(DeleteAddressesErrorState(error.toString()));
    });
  }

  void addressUpdate({
    required String id,
    required String addresses,
    required String organizationName,
    context,
  }) {
    FirebaseFirestore.instance.collection('myAddresses').doc(id).update(
      {
        'organizationName': organizationName,
        'addresses': addresses,
      },
    ).then((value) {
      showSuccessMessage(
        'Updated Successfully',
      );
      Navigator.pop(context);
      emit(
        UpdateAddressSuccessState(),
      );
    }).catchError((error) {
      print(error.toString());
      emit(
        UpdateAddressErrorState(
          error.toString(),
        ),
      );
    });
  }
}
