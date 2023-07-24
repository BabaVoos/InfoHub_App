import '../../shared/colors.dart';
import '../../shared/components/icon_broken.dart';
import '../../shared/components/my_address_widget.dart';
import 'package:flutter/material.dart';
import '../../shared/components/conponents.dart';
import 'addresses_screen.dart';

class NewAddressesScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton:  CircleAvatar(
          backgroundColor: mainColor,
          radius: 25,
          child: IconButton(
            onPressed: () {
              navigateTo(
                context,
                const AddressesScreen(),
              );
            },
            icon: const Icon(IconBroken.Search),
          ),
        ),

        body: Column(
          children: [
            MyAddressWidget(),
          ],
        ),
      ),
    );
  }
}
