import 'package:blog/utils/constants.dart';
import 'package:flutter/material.dart';

Widget customLoader({Color color = appBlue}) {
  return Center(
    child: SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    ),
  );
}
