import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/admin_controller.dart';
import '../../style/app_colors.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key}) : super(key: key);

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  List<String> notificationList = [];
  @override
  void initState() {
    getAdminNotification().then((value){
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
              return AdminNotificationWidget(
                content: notificationList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
class AdminNotificationWidget extends StatelessWidget {
  String content;

  AdminNotificationWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      color: Colors.grey,
      child: Row(
        children: [
          Image.asset(
            'assets/profile_pic.png',
            height: 30,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
    );
  }
}
