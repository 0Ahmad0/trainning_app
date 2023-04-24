import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:training_app/style/app_colors.dart';
import 'package:training_app/ui/training_organization/profile_organization.dart';
import 'package:training_app/ui/training_organization/request_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_organization_screen.dart';

class MainOrganizationScreen extends StatefulWidget {
   MainOrganizationScreen({Key? key}) : super(key: key);

  @override
  State<MainOrganizationScreen> createState() => _MainOrganizationScreenState();
}

class _MainOrganizationScreenState extends State<MainOrganizationScreen> {
  int pageIndex = 0;

  final pages = [
    HomeOrganizationScreen(),
    const RequestsScreen(),
    const ProfileOrganization(),


  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Home.svg',
                    height: 30,
                    color: pageIndex == 0? lightPurple:Colors.grey ,
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.home,
                      style: TextStyle(fontSize: 10, color: pageIndex == 0?lightPurple:Colors.black),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Padding(
                    padding:EdgeInsets.only(top: 2),
                      child: Icon(Icons.list_alt_rounded,color:  pageIndex == 1?lightPurple:Colors.grey,size: 28,)),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.requests,
                      style: TextStyle(fontSize: 10, color: pageIndex == 1?lightPurple:Colors.black),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/profile.svg',
                    height: 30,
                    color:pageIndex == 2?lightPurple:Colors.grey ,
                  ),
                   Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == 2?lightPurple:Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

