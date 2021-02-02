import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/pages/login/login_page_controller.dart';
import 'package:louvor_ics_patos/utils/cores.dart';
import 'package:louvor_ics_patos/widgets/app_button.dart';
import 'package:louvor_ics_patos/widgets/app_text.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginPageController(),
      builder: (LoginPageController _) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 24.0),
                        Hero(
                          tag: 'hero',
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 120.0,
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        AppText(
                          controller: _.tEmail,
                          keyboardType: TextInputType.emailAddress,
                          label: 'E-mail',
                          nextFocus: _.focusSenha,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 24.0),
                        Obx(
                          () => Stack(
                            children: [
                              AppText(
                                focusNode: _.focusSenha,
                                controller: _.tSenha,
                                label: 'Senha',
                                password: _.obscureTextSenha.value,
                                onFieldSubmitted: (next) => _.onClickLogin(),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 8),
                                child: IconButton(
                                  icon: Icon(
                                    _.obscureTextSenha.value
                                        ? LineAwesomeIcons.eye
                                        : LineAwesomeIcons.eye_slash,
                                    color: Cores.primary,
                                  ),
                                  onPressed: _.onPressedObscureSenha,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24.0),
                        AppButton(
                          'ENTRAR',
                          onPressed: () => _.onClickLogin(),
                          color: Cores.primary,
                        ),
                        SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() => _.loading.value
                  ? Container(
                      color: Cores.primary.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : Container())
            ],
          ),
        );
      },
    );
  }
}
