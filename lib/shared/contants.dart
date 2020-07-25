import 'package:flutter/material.dart';

const textInputDecoration= InputDecoration(
              fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  )
                   ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(2.0)),
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                    width: 2.0,
                  )
                   ),

              );