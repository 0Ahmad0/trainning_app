import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/model/student_request.dart';

import '../../controllers/admin_controller.dart';
import '../../controllers/auth_controllers.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';
import '../auth/change_password.dart';
import '../student/notifications_screen.dart';
import '../student/profile/profile_screen.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_new_company.dart';
import 'admin_notification.dart';

class UnitHomeScreen extends StatefulWidget {
  const UnitHomeScreen({Key? key}) : super(key: key);

  @override
  _UnitHomeScreenState createState() => _UnitHomeScreenState();
}

class _UnitHomeScreenState extends State<UnitHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  List<StudentRequest> studentsList = [];
  List<CompanyRequest> companyList = [];
  String name = '';
  String email = '';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getAllStudentsRequests().then((value) {
      setState(() {
        studentsList = value;
      });
    });
    getCompanyStatusRequestsToAdmin().then((value) {
      setState(() {
        companyList = value;
      });
    });
    name = SharedPreferencesHelper.sharedPreferences!.getString("name")!;
    email = SharedPreferencesHelper.sharedPreferences!.getString("email")!;
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey2,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 30,right: 10),
          child: Column(children: [
            Row(
              children: [
                Image.asset(
                  'assets/profile_pic.png',
                  height: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.changePassword),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_right_outlined),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewCompany(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.addCompany),
                  Spacer(),
                  Icon(Icons.home_work_outlined),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Spacer(),
            SizedBox(
              width: 120,
              height: 30,
              child: CustomButton(
                title: AppLocalizations.of(context)!.logout,
                background: Colors.white,
                borderColor: Colors.red,
                textColor: Colors.red,
                onclick: () {
                  logout(context);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 75,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  lightYallow,
                  lightPink,
                  lightPurple,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey2.currentState?.openDrawer();
                        },
                        child: Image.asset(
                          'assets/profile_pic.png',
                          height: 25,
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  AdminNotifications(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      indicatorColor: lightPurple,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.companies,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.students,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: companyList.length,
                  itemBuilder: (context, index) {
                    return CompanyStatusWidget(
                      companyRequest: companyList[index],
                    );
                  },
                ),
                ListView.builder(
                  itemCount: studentsList.length,
                  itemBuilder: (context, index) {
                    return StudentRequestWidget(
                      studentRequest: studentsList[index],
                    );
/*
                     return StudentRequestWidget(studentRequest: null,);
*/
                  },
                ),

                // second tab bar view widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyStatusWidget extends StatelessWidget {
  CompanyRequest companyRequest;

  CompanyStatusWidget({Key? key, required this.companyRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 70,
      child: Row(
        children: [
          Text(
            companyRequest.name,
            style: const TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            '${AppLocalizations.of(context)!.status}:${companyRequest.status == '2' ? AppLocalizations.of(context)!.approved :companyRequest.status == '1'? AppLocalizations.of(context)!.rejected:AppLocalizations.of(context)!.pending}',
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class StudentRequestWidget extends StatelessWidget {
  StudentRequestWidget({Key? key, required this.studentRequest})
      : super(key: key);
  StudentRequest studentRequest;

  @override
  Widget build(BuildContext context) {
    print(studentRequest.status);
    print("studentRequest.status");
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${AppLocalizations.of(context)!.name}: ${studentRequest.name}'),
          Text(
              '${AppLocalizations.of(context)!.major}: ${studentRequest.major}'),
          Row(
            children: [
              Spacer(),
              Text(
                  '${AppLocalizations.of(context)!.status}:${studentRequest.status == '2' ? AppLocalizations.of(context)!.approved :studentRequest.status == '1'? AppLocalizations.of(context)!.rejected:AppLocalizations.of(context)!.pending}')
            ],
          )
        ],
      ),
    );
  }
}
