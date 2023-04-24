import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training_app/style/app_colors.dart';
import 'package:training_app/ui/student/home_student.dart';
import 'package:training_app/ui/student/jobs_screen.dart';
import 'package:training_app/ui/student/map.dart';
import 'package:training_app/ui/student/profile/profile_screen.dart';
import 'package:training_app/ui/student/search_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  final pages = [
    StudentHome(),
    SearchScreen(),
    JobScreen(),
    const ProfileScreen(),
    const MapSample(),
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
                    color: pageIndex == 0? lightPurple : Colors.grey,
                  ),
                  Expanded(
                    child: Text(
                     AppLocalizations.of(context)!.home,
                      style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == 0 ? lightPurple : Colors.grey,
                      ),
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
                children: [
                  SvgPicture.asset('assets/search.svg',
                      height: 30,
                      color: pageIndex == 1 ? lightPurple : Colors.grey),
                  Expanded(
                    child: Text(
                        AppLocalizations.of(context)!.search,
                      style: TextStyle(
                          fontSize: 10,
                          color: pageIndex == 1 ? lightPurple : Colors.grey),
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
                    'assets/job.svg',
                    height: 30,
                     color: pageIndex == 2 ? lightPurple : Colors.grey
                  ),
                  Expanded(
                    child: Text(
                        AppLocalizations.of(context)!.jobs,
                      style: TextStyle(fontSize: 10, color: pageIndex == 2 ? lightPurple : Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/profile.svg',
                    height: 30,
                    color: pageIndex == 3 ? lightPurple : Colors.grey,

                  ),
                   Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.profile,
                      style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == 3 ? lightPurple : Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 4;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Icon(Icons.explore_outlined,size:30,  color: pageIndex == 4 ? lightPurple : Colors.grey,),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.explore,
                      style: TextStyle(
                        fontSize: 10,
                        color: pageIndex == 4 ? lightPurple : Colors.grey,
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
