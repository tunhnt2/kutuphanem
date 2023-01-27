import 'dart:ui';
import 'package:flutter/material.dart';

TextStyle style = TextStyle(color: Colors.black, fontSize: 25);

 myDialog(BuildContext context, {String? title, String? content, VoidCallback? ok}) async {
    showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(title!),
                        content: Text(content!),
                        actions: [
                          TextButton(
                              onPressed: ok,
                              child: Text("Evet")),
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text("Hayır"))
                        ],
                      );
                    });
  }