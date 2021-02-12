import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:louvor_ics_patos/pages/home/home_page_controller.dart';

class HomePage extends StatelessWidget {
  int index;


  HomePage({this.index = 0});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(index),
      builder: (_) {
        return Scaffold(
          body: Obx(
            () {
              Get.focusScope.unfocus();
              return IndexedStack(
                  index: _.currentIndex.value, children: _.pages);
            },
          ),
          bottomNavigationBar: Stack(
            children: [
              Obx(
                () => BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) => _.currentIndex.value = index,
                  currentIndex: _.currentIndex.value,
                  showUnselectedLabels: true,
                  elevation: 16.0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      label: 'Cronograma',
                      icon: Icon(LineAwesomeIcons.calendar),
                    ),
                    BottomNavigationBarItem(
                      label: 'Louvores',
                      icon: Icon(LineAwesomeIcons.music),
                    ),
                    BottomNavigationBarItem(
                      label: 'Grupos',
                      icon: Icon(LineAwesomeIcons.group),
                    ),
                    BottomNavigationBarItem(
                      label: 'Perfil',
                      icon: Icon(LineAwesomeIcons.user),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
