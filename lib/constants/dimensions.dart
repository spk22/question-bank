import 'package:jamoverflow/constants/colors.dart';
import 'package:flutter/material.dart';

const double vBox1 = 10.0;
const double vBox2 = 20.0;
const double vBox3 = 35.0;
const double vBox4 = 45.0;

const double hBox1 = 10.0;
const double hBox2 = 20.0;
const double hBox3 = 35.0;
const double hBox4 = 45.0;

const SizedBox vSizedBox1 = SizedBox(height: vBox1);
const SizedBox vSizedBox2 = SizedBox(height: vBox2);
const SizedBox vSizedBox3 = SizedBox(height: vBox3);
const SizedBox vSizedBox4 = SizedBox(height: vBox4);

const SizedBox hSizedBox1 = SizedBox(width: hBox1);
const SizedBox hSizedBox2 = SizedBox(width: hBox2);
const SizedBox hSizedBox3 = SizedBox(width: hBox3);
const SizedBox hSizedBox4 = SizedBox(width: hBox4);

const double buttonTextSize1 = 16;
const double buttonTextSize2 = 24;

const double vPaddingSize1 = 4;
const double vPaddingSize2 = 8;
const double vPaddingSize3 = 20;

const double hPaddingSize1 = 4;
const double hPaddingSize2 = 8;
const double hPaddingSize3 = 25;

const double radiusSize1 = 10;

const double margin1 = 8;
const double margin2 = 16;

const double borderWidth1 = 2;

const double opacity1 = 0.4;

const buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: buttonTextSize2,
  fontWeight: FontWeight.bold,
);
var buttonStyle = ElevatedButton.styleFrom(
  primary: ConstantColors.accentColor,
  padding: const EdgeInsets.all(hPaddingSize2),
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radiusSize1))),
);

const appbarTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: buttonTextSize1,
  fontWeight: FontWeight.bold,
);
