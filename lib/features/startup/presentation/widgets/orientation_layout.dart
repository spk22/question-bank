import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/constants/dimensions.dart';
import 'package:jamoverflow/core/shared/login_details.dart';
import 'package:jamoverflow/core/shared/providers.dart';
import 'package:jamoverflow/features/user_auth/presentation/pages/login_page.dart';
import 'package:jamoverflow/features/user_auth/presentation/pages/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrientationLayout extends StatefulWidget {
  OrientationLayout({Key key}) : super(key: key);

  @override
  _OrientationLayoutState createState() => _OrientationLayoutState();
}

class _OrientationLayoutState extends State<OrientationLayout> {
  // LoginDetails loginDetails;

  // Future<void> setLoginDetails() async {
  //   String boxName = 'user';
  //   var box = await Hive.openBox(boxName);
  //   loginDetails = LoginDetails(
  //     saveStatus: box.get('isSaved', defaultValue: false),
  //     email: box.get('email'),
  //     password: box.get('password'),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // setLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Widget widget;
    switch (orientation) {
      case Orientation.portrait:
        widget = Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: hPaddingSize3, vertical: vPaddingSize3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logoAnimation',
                child: Image.asset(
                  'assets/images/logo.gif',
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: hBox4,
                width: double.infinity,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () async {
                    navigateToLogin(context);
                  },
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: buttonTextStyle,
                  ),
                ),
              ),
              SizedBox(
                height: hBox4,
                width: double.infinity,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () async {
                    navigateToRegister(context);
                  },
                  child: Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case Orientation.landscape:
        widget = Row(
          children: [
            Expanded(
              child: Hero(
                tag: 'logoAnimation',
                child: Image.asset(
                  'assets/images/logo.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: margin2),
              color: ConstantColors.dividerColor,
              width: borderWidth1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: hPaddingSize3, vertical: vPaddingSize3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: vBox4,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          navigateToLogin(context);
                        },
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: vBox4,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          navigateToRegister(context);
                        },
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        break;
    }
    return widget;
  }

  Future<void> navigateToLogin(BuildContext context) async {
    final backend = context.read(backendProvider);
    await backend.initServer();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Future<void> navigateToRegister(BuildContext context) async {
    final backend = context.read(backendProvider);
    await backend.initServer();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }
}
