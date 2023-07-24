import 'package:algad_infohub/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'icon_broken.dart';

PreferredSizeWidget buildAppBar(context,) => AppBar(
  leading: IconButton(
    icon: const Icon(IconBroken.Arrow___Right_2),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  titleSpacing: 0,
  title: const Text(
    'رجوع',
    style: TextStyle(fontSize: 22),
  ),
  backgroundColor: mainColor,
  elevation: 0,
);