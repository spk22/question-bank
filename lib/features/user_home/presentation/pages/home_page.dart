import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/constants/dimensions.dart';
import 'package:jamoverflow/core/shared/providers.dart';
import 'package:jamoverflow/features/startup/presentation/pages/startup.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read(singleUser.getUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: appbarTitleStyle),
        centerTitle: true,
        backgroundColor: ConstantColors.darkPrimaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              size: buttonTextSize2,
              color: ConstantColors.accentColor,
            ),
            onPressed: () async {
              await userSignOut(context, user);
            },
          ),
        ],
      ),
      body: Container(
        color: ConstantColors.primaryTextColor,
        alignment: Alignment.center,
        child: Center(
          child: Text('${user.uid.value.getOrElse(() => null)}'),
        ),
      ),
    );
  }

  Future<void> userSignOut(BuildContext context, User user) async {
    final backend = context.read(backendProvider);
    final bool success =
        await backend.signOut(user.uid.value.getOrElse(() => null));
    if (success) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Startup()),
      );
    }
  }
}
