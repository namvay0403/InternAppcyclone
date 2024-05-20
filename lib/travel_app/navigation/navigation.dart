import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intern_appcyclone/travel_app/pages/account_page/account_page.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_bloc/bloc/login_bloc.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/login_page.dart';
import 'package:intern_appcyclone/travel_app/pages/login_page/logout_cubit/cubit/logout_cubit.dart';
import 'package:intern_appcyclone/utilities/const/colors.dart';
import 'package:intern_appcyclone/utilities/const/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../authentication/repository/auth_repository.dart';
import '../pages/favourite_page/favourite_page.dart';
import '../pages/home_page/home_page.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const Scaffold(
      body: Center(
        child: Text('Page 3'),
      ),
    ),
    const AccountPage(),
  ];

  int pageIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            textStyle: AppStyle.heading
                .copyWith(color: AppColor.primaryColor, fontSize: 16),
            iconSize: 26,
            gap: 5,
            duration: const Duration(milliseconds: 400),
            color: Colors.grey[600],
            activeColor: AppColor.primaryColor,
            tabBackgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.all(12),
            onTabChange: (index) {
              pageController.jumpToPage(index);
              setState(() {
                pageIndex = index;
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: AppLocalizations.of(context)!.home,
              ),
              GButton(
                icon: Icons.favorite,
                text: AppLocalizations.of(context)!.favorite,
              ),
              GButton(
                icon: Icons.storefront,
                text: AppLocalizations.of(context)!.history,
              ),
              GButton(
                icon: Icons.person,
                text: AppLocalizations.of(context)!.setting,
              ),
            ],
          ),
        ),
      ),
      body: PageView(        /// Wrapping the tabs with PageView
        controller: pageController,
        children: pages,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
    );
  }
}
