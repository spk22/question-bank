import 'package:flutter/material.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/features/startup/presentation/widgets/orientation_layout.dart';

class Startup extends StatelessWidget {
  const Startup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColors.primaryColor,
      child: Center(
        child: OrientationLayout(),
      ),
    );
  }
}
