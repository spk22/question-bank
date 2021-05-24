import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jamoverflow/constants/colors.dart';
import 'package:jamoverflow/constants/dimensions.dart';
import 'package:jamoverflow/core/shared/login_details.dart';
import 'package:jamoverflow/core/shared/providers.dart';

class DetailsConsumer extends ConsumerWidget {
  final List<String> authRoles;
  final ValueChanged<bool> onSaved;
  final String boxName;
  const DetailsConsumer({
    Key key,
    this.authRoles,
    this.onSaved,
    this.boxName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final loginDetailsAsync = watch(loginDetailsProvider(boxName));
    return loginDetailsAsync.map(
      data: (_) => dataWidget(context, _.value),
      loading: (_) => CircularProgressIndicator(),
      error: (_) => Text(
        _.error.toString(),
        style: TextStyle(color: Colors.red, fontSize: buttonTextSize1),
      ),
    );
  }

  Widget dataWidget(BuildContext context, LoginDetails details) {
    return Column(
      children: [
        FormBuilderDropdown(
          name: 'authType',
          decoration: InputDecoration(
            labelText: 'Login as',
            labelStyle: TextStyle(color: ConstantColors.accentColor),
            alignLabelWithHint: true,
          ),
          initialValue: authRoles[0],
          allowClear: true,
          hint: Text('Your Role'),
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(context)]),
          items: authRoles
              .map(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(role),
                ),
              )
              .toList(),
        ),
        vSizedBox1,
        FormBuilderTextField(
          name: 'email',
          initialValue: (details.saveStatus) ? details.email : null,
          decoration: InputDecoration(
            labelText: 'Enter registered email',
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
          initialValue: (details.saveStatus) ? details.password : null,
          decoration: InputDecoration(
            labelText: 'Enter a password',
            labelStyle: TextStyle(color: ConstantColors.accentColor),
          ),
          obscureText: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ),
        vSizedBox1,
        FormBuilderSwitch(
          name: 'saveDetails',
          initialValue: details.saveStatus,
          title: Text(' Save login details?'),
          activeColor: ConstantColors.accentColor,
          activeTrackColor: ConstantColors.accentColor.shade100,
          onSaved: (newStatus) async {
            onSaved(newStatus);
            await details.updateDetails();
          },
        ),
      ],
    );
  }
}
