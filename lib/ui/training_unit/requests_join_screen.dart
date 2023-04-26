import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/admin_controller.dart';
import 'package:training_app/controllers/auth_controllers.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/model/student_request.dart';
import 'package:training_app/ui/training_unit/company_request_page.dart';

import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';
import '../auth/change_password.dart';
import '../student/notifications_screen.dart';
import '../student/profile/profile_screen.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'admin_notification.dart';

class RequestsJoinScreen extends StatefulWidget {
  RequestsJoinScreen({Key? key}) : super(key: key);

  @override
  State<RequestsJoinScreen> createState() => _RequestsJoinScreenState();
}

class _RequestsJoinScreenState extends State<RequestsJoinScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey3 = GlobalKey<ScaffoldState>();
  List<StudentRequest> pendingList = [];
  List<CompanyRequest> pendingCompanyList = [];
  String name = '';
  String email = '';

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getStudentsPendingRequest().then((value) {
      pendingList = value;
      setState(() {});
    });
    getCompanyRequestsToAdmin().then((value) {
      pendingCompanyList = value;
      setState(() {});

    });
     name = SharedPreferencesHelper.sharedPreferences!.getString("name")!;
    //name = 'name';
     email = SharedPreferencesHelper.sharedPreferences!.getString("email")!;
    //email = 'email';
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
      extendBodyBehindAppBar: true,
      key: _scaffoldKey3,
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
                          _scaffoldKey3.currentState?.openDrawer();
                        },
                        child: Image.asset(
                          'assets/profile_pic.png',
                          height: 25,
                        ),
                      ),
                      Spacer(),
                       Text(
                        AppLocalizations.of(context)!.requests,
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
                      tabs:  [
                        Tab(
                          text:AppLocalizations.of(context)!.companies ,
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
                pendingCompanyList.isEmpty
                    ? Center(child: Text('لا يوجد طلبات'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: pendingCompanyList.length,
                        itemBuilder: (context, index) {
                          return CompanyPendingRequest(
                            companyRequest: pendingCompanyList[index],
                          );
                        },
                      ),
                pendingList.isEmpty
                    ? Center(child: Text('لا يوجد طلبات'))
                    : ListView.builder(
                        itemCount: pendingList.length,
                        itemBuilder: (context, index) {
                          return StudentPendingRequest(
                            studentRequest: pendingList[index],
                          );
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

class CompanyPendingRequest extends StatelessWidget {
  CompanyRequest companyRequest;

  CompanyPendingRequest({
    Key? key,
    required this.companyRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompanyRequestPage(
              companyRequest: companyRequest,
            ),
          ),
        );
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding:
            const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffEEECEC),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(companyRequest.image),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  companyRequest.name,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  companyRequest.address,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            /* Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  width: 100,
                  child: CustomButton(
                    textSize: 12,
                    title: 'Approve',
                    background: Colors.white,
                    borderColor: darkPink,
                    textColor: darkPink,
                    onclick: () {},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 25,
                  width: 100,
                  child: CustomButton(
                    textSize: 12,
                    title: 'Reject',
                    background: Colors.white,
                    borderColor: darkPink,
                    textColor: darkPink,
                    onclick: () {},
                  ),
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}

class StudentPendingRequest extends StatelessWidget {
  StudentPendingRequest({
    Key? key,
    required this.studentRequest,
  }) : super(key: key);
  StudentRequest studentRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xffEEECEC),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${AppLocalizations.of(context)!.name}:${studentRequest.name}',
                style: TextStyle(fontSize: 15),
              ),
              Expanded(
                child: Text(
                  '${AppLocalizations.of(context)!.major}:${studentRequest.major} ',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: 80,
                child: CustomButton(
                  textSize: 12,
                  title: AppLocalizations.of(context)!.approve,
                  background: Colors.white,
                  borderColor: darkPink,
                  textColor: darkPink,
                  onclick: () {
                    acceptRequest(studentRequest.id, context);
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 30,
                width: 80,
                child: CustomButton(
                  textSize: 12,
                  title: AppLocalizations.of(context)!.reject,
                  background: Colors.white,
                  borderColor: darkPink,
                  textColor: darkPink,
                  onclick: () {
                    rejectRequest(
                        studentRequest.id, context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
