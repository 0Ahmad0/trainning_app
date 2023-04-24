import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/controllers/student_controller.dart';
import '../../main.dart';
import '../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
    return Scaffold(
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
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 10,
                            color: Colors.white,
                          ),
                          Text(
                            AppLocalizations.of(context)!.home,
                            style: TextStyle(color: Colors.white, fontSize: 10),
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
          SizedBox(
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

class NotificationWidget extends StatelessWidget {
  String content;

  NotificationWidget({Key? key, required this.content}) : super(key: key);

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
              content == 'accept'
                  ? Provider.of<LanguageModel>(context, listen: false).locale ==
                  const Locale('ar')
                  ? "تم قبول طلبك"
                  : "your request has been accepted"
                  : Provider.of<LanguageModel>(context, listen: false).locale ==
                  const Locale('ar')
                  ? 'تم إرسال الطلب إلى وحدة التدريب'
                  : 'The request has been sent to a training unit',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

        ],
      ),
    );
  }
}
