import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamoverflow/constants/app_constants.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/constants/dimensions.dart';
import 'package:jamoverflow/core/shared/providers.dart';
import 'package:jamoverflow/core/shared/show_alert_dialog.dart';
import 'package:jamoverflow/features/user_auth/domain/entities/user.dart';
import 'package:jamoverflow/features/user_auth/domain/usecases/signup.dart';
import 'package:dartz/dartz.dart' as Dartz;
import 'package:jamoverflow/core/error/failures.dart' as Failures;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String passwordText;

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
            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(
                labelText: 'Enter an email',
                labelStyle: TextStyle(color: ConstantColors.accentColor),
                hintText: 'eg: test@mail.com',
                hintStyle: TextStyle(color: ConstantColors.accentColor),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.email(context),
              ]),
            ),
            vSizedBox1,
            FormBuilderTextField(
              name: 'password',
              decoration: InputDecoration(
                labelText: 'Enter a password',
                labelStyle: TextStyle(color: ConstantColors.accentColor),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  passwordText = value;
                });
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.minLength(context, 5),
              ]),
            ),
            vSizedBox1,
            FormBuilderTextField(
              name: 'repeatPassword',
              decoration: InputDecoration(
                labelText: 'Repeat password',
                labelStyle: TextStyle(color: ConstantColors.accentColor),
              ),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.minLength(context, 5),
                FormBuilderValidators.equal(context, passwordText),
              ]),
            ),
            vSizedBox1,
            FormBuilderCheckbox(
              name: 'termsAndConditions',
              title: Row(
                children: [
                  Text('I accept '),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: ConstantColors.accentColor),
                      text: 'Terms and Conditions',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await showAlertDialog(
                            context: context,
                            title: 'Terms and Conditions',
                            content: TERMS_AND_CONDITIONS,
                            defaultActionText: 'OK',
                          );
                        },
                    ),
                  ),
                ],
              ),
              initialValue: false,
              activeColor: ConstantColors.accentColor,
              checkColor: Colors.white,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ),
            vSizedBox3,
            SizedBox(
              height: vBox4,
              width: double.infinity,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () async {
                  if (_formKey.currentState.saveAndValidate()) {
                    await signupUser(context);
                  }
                },
                child: Text(
                  'Signup',
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

  Future<void> signupUser(BuildContext context) async {
    // inject Usecase
    final usecase = context.read(signupUsecaseProvider);
    String email = _formKey.currentState.value['email'];
    String password = _formKey.currentState.value['password'];
    final Dartz.Either<Failures.Failure, User> authEither =
        await usecase.call(Param(email: email, password: password));
    authEither.fold(
      (failure) => showAlertDialog(
        context: context,
        title: 'Some Error',
        content: failure.message,
        defaultActionText: 'OK',
      ),
      (user) async {
        await showAlertDialog(
          context: context,
          title: 'Success!',
          content: 'User created successfully!',
          defaultActionText: 'OK',
        );
      },
    );
  }
}
