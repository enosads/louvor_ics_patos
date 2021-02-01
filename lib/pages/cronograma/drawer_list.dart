import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/firebase/firebase_service.dart';
import 'package:louvor_ics_patos/pages/home/home_page_controller.dart';
import 'package:louvor_ics_patos/pages/login/login_page.dart';
import 'package:louvor_ics_patos/utils/cores.dart';

class AppDrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser;
    Get.focusScope.unfocus();
    return Drawer(
        child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text('Louvor ICS Patos'),
          accountEmail: Text(currentUser.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Cores.primary,
            radius: 120.0,
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            LineAwesomeIcons.calendar,
            color: Cores.primary,
          ),
          title: Text('Cronograma'),
          onTap: () {
            HomePageController.to.currentIndex.value = 0;
            Get.back();
          },
        ),
        ListTile(
          leading: Icon(
            LineAwesomeIcons.music,
            color: Cores.primary,
          ),
          title: Text('Louvores'),
          onTap: () {
            HomePageController.to.currentIndex.value = 1;
            Get.back();
          },
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(
                LineAwesomeIcons.sign_out,
                color: Cores.primary,
              ),
              title: Text(
                'Logout',
              ),
              onTap: () {
                FirebaseService.logout();
                Get.offAll(LoginPage());
              },
            ),
          ),
        )
      ],
    ));
  }
}
