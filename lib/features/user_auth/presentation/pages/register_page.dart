import 'package:flutter/material.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/features/user_auth/presentation/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: ConstantColors.primaryTextColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: (orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.height * 0.5
                  : MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: ConstantColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Hero(
                  tag: 'logoAnimation',
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: ((orientation == Orientation.portrait))
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
