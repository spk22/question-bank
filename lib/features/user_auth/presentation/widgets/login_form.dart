import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hive/hive.dart';
import 'package:jamoverflow/config/auth_types.dart';
import 'package:jamoverflow/constants/dimensions.dart';
import 'package:jamoverflow/core/shared/login_details.dart';
import 'package:jamoverflow/core/shared/providers.dart';
import 'package:jamoverflow/core/shared/show_alert_dialog.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';
import 'package:jamoverflow/features/user_auth/domain/usecases/signin.dart';
import 'package:dartz/dartz.dart' as Dartz;
import 'package:jamoverflow/core/error/failures.dart' as Failures;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jamoverflow/features/user_auth/presentation/widgets/details_consumer.dart';
import 'package:jamoverflow/features/user_home/presentation/pages/home_page.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<String> authRoles = ['user', 'admin'];
  bool newStatus = false;
  var boxName = "user";

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: hPaddingSize3,
          vertical: vPaddingSize3,
        ),
        child: Column(
          children: [
            DetailsConsumer(
              authRoles: authRoles,
              onSaved: (val) {
                newStatus = val;
              },
              boxName: boxName,
            ),
            vSizedBox3,
            SizedBox(
              height: vBox4,
              width: double.infinity,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () async {
                  if (_formKey.currentState.saveAndValidate()) {
                    LoginDetails loginDetailsObj;
                    // Get recent state of LoginDetails from Provider
                    final loginDetailsAsync =
                        context.read(loginDetailsProvider(boxName));
                    loginDetailsAsync.map(
                      data: (_) {
                        loginDetailsObj = _.value;
                      },
                      loading: (_) => null,
                      error: (_) => null,
                    );
                    // save recent state of LoginDetails to Hive
                    var box = await Hive.openBox(boxName);
                    print('newStatus: $newStatus');
                    box.put('isSaved', newStatus);
                    if (newStatus) {
                      // save both email & password
                      box.put('email', _formKey.currentState.value["email"]);
                      box.put(
                          'password', _formKey.currentState.value["password"]);
                    } else {
                      box.delete('email');
                      box.delete('password');
                    }
                    loginDetailsObj?.updateDetails();
                    await signinUser(context);
                  }
                },
                child: Text(
                  'Signin',
                  textAlign: TextAlign.center,
                  style: buttonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signinUser(BuildContext context) async {
    // inject Usecase
    final usecase = context.read(signinUsecaseProvider);
    String email = _formKey.currentState.value['email'];
    String password = _formKey.currentState.value['password'];
    var authType = nameToAuthType[_formKey.currentState.value['authType']];
    final Dartz.Either<Failures.Failure, User> authEither = await usecase
        .call(Param(authType: authType, email: email, password: password));
    authEither.fold(
      (failure) => showAlertDialog(
        context: context,
        title: 'Some Error',
        content: failure.message,
        defaultActionText: 'OK',
      ),
      (user) async {
        // one-time user instantiated for this login session
        singleUser = SingleUser(Provider<User>((ref) => user));
        // navigate to home page
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      },
    );
  }
}
