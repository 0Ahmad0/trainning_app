import 'package:flutter/material.dart';
import 'package:training_app/controllers/auth_controllers.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/ui/training_organization/organization_notification.dart';
import 'package:training_app/ui/training_organization/profile_organization.dart';

import '../../controllers/company_controller.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';
import '../auth/change_password.dart';
import '../student/profile/profile_screen.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeOrganizationScreen extends StatefulWidget {
  HomeOrganizationScreen({Key? key}) : super(key: key);

  @override
  State<HomeOrganizationScreen> createState() => _HomeOrganizationScreenState();
}

class _HomeOrganizationScreenState extends State<HomeOrganizationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldOrgKey = GlobalKey<ScaffoldState>();
  List<CompanyRequest> statusList = [];
 String name='';
 String email='';
  @override
  void initState() {
    getCompanyRequests().then((value) {
      statusList = value;
      setState(() {});
    });
    name = SharedPreferencesHelper.sharedPreferences!.getString("nameCom")!;
    email = SharedPreferencesHelper.sharedPreferences!.getString("emailCom")??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldOrgKey,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30,right: 10),
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
                  children:  [
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
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileOrganization(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.profile,
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_right_outlined),
                  ],
                ),
              ),
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
                  Text(
                    AppLocalizations.of(context)!.changePassword,
                  ),
                  Spacer(),
                  const Icon(Icons.keyboard_arrow_right_outlined),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const Spacer(),
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
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 70,
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        _scaffoldOrgKey.currentState?.openDrawer();
                      },
                      child: Image.asset(
                        'assets/profile_pic.png',
                        height: 30,
                      )),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.home,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                               OrganizationNotification(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.requestStatus,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: statusList.length,
            itemBuilder: (context, index) {
              return StatusWidget(
                companyRequest: statusList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  CompanyRequest companyRequest;

  StatusWidget({Key? key, required this.companyRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: const Color(0xffC8C8C8),
      ),
      child: Row(
        children: [
          Text("${AppLocalizations.of(context)!.requestStatus}: "),
          Text(companyRequest.status == '2' ? AppLocalizations.of(context)!.approved:companyRequest.status =='0'? AppLocalizations.of(context)!.pending:AppLocalizations.of(context)!.rejected),
        ],
      ),
    );
  }
}
