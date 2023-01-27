import 'package:flutter/material.dart';

laoding(context) => showDialog(
    context: context,
    builder: (ctx) => Center(
      child: Container(
        width: 30,
        height: 30,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
    ),
    barrierDismissible: false);
