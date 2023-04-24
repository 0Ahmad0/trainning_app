import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/ui/auth/change_password.dart';
import 'package:training_app/ui/contact_info.dart';
import 'package:training_app/ui/student/chatbot_screen.dart';
import 'package:training_app/ui/student/notifications_screen.dart';
import 'package:training_app/ui/student/profile/profile_screen.dart';
import 'package:training_app/ui/student/training_details.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/auth_controllers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../controllers/student_controller.dart';
import '../../model/company.dart';
import '../../style/app_colors.dart';

class StudentHome extends StatefulWidget {
  StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CompanyRequest> companiesList = [];

  @override
  void initState() {
    getCompanyToStudent().then((value) {
      companiesList = value;
      setState(() {});
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/profile_pic.png',
                      height: 30,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      /*  Future<String> uploadImageToFirebase(File imageFile) async {
                        final StorageReference storageReference =
                        FirebaseStorage().ref().child('images/${DateTime.now()}.jpg');
                        final StorageUploadTask uploadTask = storageReference.putFile(imageFile);
                        final StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
                        final String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
                        return imageUrl;
                      }
                      void addObjectToFirestore(String imageUrl) async {
                        await Firestore.instance.collection('objects').add({
                          'imageUrl': imageUrl,
                          'timestamp': Timestamp.now(),
                        });
                      }*/
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 25,
                children: companiesList.map((e) {
                  return TrainingAdWidget(
                    company: e,
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}




class _DrawerWidgetState extends State<DrawerWidget> {

  var name;
  var email;
 @override
  void initState() {
   name=  SharedPreferencesHelper.sharedPreferences!.getString("name")!;
   email=SharedPreferencesHelper.sharedPreferences!.getString("email")!;
    setState(() {

    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 30, right: 10),
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
                  Text(email),
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
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.profile,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
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
                  builder: (context) => const ContactInfo(),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.contactUs,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChatBotScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.helpAndSupport,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
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
    );
  }
}

class TrainingAdWidget extends StatelessWidget {
  TrainingAdWidget({Key? key, required this.company}) : super(key: key);
  CompanyRequest company;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TrainingDetails(
              company: company,
            ),
          ),
        );
      },
      child: Container(
        height: 130,
        width: 145,
        padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xffE1BDF1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              //color of shadow
              spreadRadius: 2,
              //spread radius
              blurRadius: 5,
              // blur radius
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(company.image),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  company.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              //color: Colors.red,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        company.address,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 27,
                  child: ElevatedButton(
                    onPressed: () async {
                      _launchUrl(company.link).then((value) {
                        addApplicant(context: context, companyId: company.docId);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.apply,
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                SizedBox(
                  height: 27,
                  child: ElevatedButton(
                    onPressed: () async {
                      saveJob(companyId:company.docId, context: context );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 11,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch url');
    }
  }
}
