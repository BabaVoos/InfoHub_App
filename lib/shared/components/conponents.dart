import 'package:algad_infohub/modules/news_screen/news_screen.dart';
import 'package:algad_infohub/shared/colors.dart';
import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
