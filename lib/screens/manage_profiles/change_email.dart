import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/custom/common_input.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/custom/common_widget.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:email_validator/email_validator.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  final my_email_controller = TextEditingController();
  String value;

  @override
  void dispose() {
    my_email_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Const.kPaddingHorizontal, vertical: 10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [buildContactDetailsContainer(context)],
                  ))
            ],
          ),
        ),
      ),
    );
  }


  Widget buildContactDetailsContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            onChanged: (text) {
              value = text;
            },
            controller: my_email_controller,
            decoration:
                InputStyle.inputDecoration_text_field(hint: "john@gmail.com"),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
              onTap: () {
                var validated = EmailValidator.validate(value);
                print(validated);
              },
              child: Container(
                height: 45,
                width: DeviceInfo(context).width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: [
                      MyTheme.gradient_color_1,
                      MyTheme.gradient_color_2,
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).save_change_btn_text,
                    style: Styles.bold_white_14,
                  )
                  ,
                ),
              ),),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(),
        icon: Image.asset(
          'assets/icon/icon_pop.png',
          height: 16,
          width: 23,
        ),
      ),
      titleSpacing: 0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        AppLocalizations.of(context).change_email_screen_appbar_title,
        style: Styles.bold_arsenic_14,
      )
    );
  }
}
