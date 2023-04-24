import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_app/ui/training_organization/profile_organization.dart';
import '../../controllers/auth_controllers.dart';
import '../../controllers/company_controller.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../model/company_request.dart';
import '../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../auth/change_password.dart';
import '../student/profile/profile_screen.dart';
import '../widgets/custom_button.dart';
import 'organization_notification.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<CompanyRequest> requestList = [];
  String name = '';
  String email = '';

  @override
  void initState() {
    getCompanyRequests().then((value) {
      print(value.length);
      setState(() {
        requestList = value;
      });
    });
    name = SharedPreferencesHelper.sharedPreferences!.getString("name")!;
    email = SharedPreferencesHelper.sharedPreferences!.getString("email")??"";
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
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
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ProfileScreen(),
                  ),
                );
              },
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileOrganization(),
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
                  const Spacer(),
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

                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.requests,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
          /* requestList.isEmpty
              ? const Center(child: Text('لا يوجد طلبات'))
              : */
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: requestList.length,
              itemBuilder: (context, index) {
                print(requestList.length);
                print("requestList.length");

                return RequestCompanyWidget(
                  companyRequest: requestList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestCompanyWidget extends StatelessWidget {
  RequestCompanyWidget({Key? key, required this.companyRequest})
      : super(key: key);
  CompanyRequest companyRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        color: const Color(0xffC8C8C8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            //color of shadow
            spreadRadius: 2,
            //spread radius
            blurRadius: 5,
            // blur radius
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
              )),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("رقم الطلب:"),
                  Text(companyRequest.number??"")
                ],
              ),
              Text(
                companyRequest.name,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                companyRequest.address,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
