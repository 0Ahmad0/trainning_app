import 'package:flutter/material.dart';

import '../../controllers/company_controller.dart';
import '../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../student/notifications_screen.dart';

class OrganizationNotification extends StatefulWidget {
   OrganizationNotification({Key? key}) : super(key: key);

  @override
  State<OrganizationNotification> createState() => _OrganizationNotificationState();
}

class _OrganizationNotificationState extends State<OrganizationNotification> {
  List<String> notificationList = [];
  @override
  void initState() {
    getNotification().then((value){
      notificationList =value;
      setState(() {});

    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 10,
                            color: Colors.white,
                          ),
                          Text(
                            AppLocalizations.of(context)!.home,
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    AppLocalizations.of(context)!.notification,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          notificationList.isEmpty
              ? const Center(
            child: Text("لا يوجد اشعارات"),
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: notificationList.length,
            itemBuilder: (BuildContext context, int index) {
              return NotificationWidget(
                content: notificationList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
