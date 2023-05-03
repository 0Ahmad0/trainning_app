import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/student_controller.dart';
import 'package:training_app/ui/student/profile/edit_cv_screen.dart';
import 'package:training_app/ui/student/profile/edit_languages.dart';
import 'package:training_app/ui/student/profile/edit_personal_info.dart';
import 'package:training_app/ui/student/profile/edit_skill.dart';
import '../../../controllers/shared_preference_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'edit_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? isSendRequest;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getUserData();
      isSendRequest =
          SharedPreferencesHelper.sharedPreferences!.getString('isSendRequest');
    });
    super.initState();

  }
  Student? student;
  String? studentName=StudentController.student.name;
  String? img=StudentController.student.img;
  getUserData() async {
    String? uid=  SharedPreferencesHelper.sharedPreferences!
        .getString('uid');
    if(uid!=null){
     await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
        student = Student.fromJson(value.data()!);
        StudentController.student=student!;
        if(student!.name!=""){
          studentName =student!.name;

        }if(student!.img!=""){
          img=student!.img;
          print("ommmmmg");
          print(img);
          setState(() {
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context)!.profile,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    height: MediaQuery.of(context).size.height / 8,
                    width: double.infinity,
                    color: lightGrey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      img!=null?SizedBox(
                    height: 80,
                        width: 80,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(img!),
                        )):SizedBox(
                            height: MediaQuery.of(context).size.height / 9,
                            child: Image.asset('assets/profile_pic.png'),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text("${AppLocalizations.of(context)!.name}:"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Text(studentName??""),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    width: double.infinity,
                    color: lightGrey,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditPersonalInfo(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .personalInformation),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: MediaQuery.of(context).size.height / 10,
                    width: double.infinity,
                    color: lightGrey,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditSkills(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child:
                                  Text(AppLocalizations.of(context)!.skills)),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: MediaQuery.of(context).size.height / 10,
                    width: double.infinity,
                    color: lightGrey,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditLanguages(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child:
                                  Text(AppLocalizations.of(context)!.language)),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: MediaQuery.of(context).size.height / 10,
                    width: double.infinity,
                    color: lightGrey,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  TrainingPlanScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children:  [
                          Expanded(child: Text(
                              AppLocalizations.of(context)!.experience
                          )),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  isSendRequest == '2'
                      ? CustomButton(
                    background: Colors.white,
                    borderColor: lightPink,
                    title: AppLocalizations.of(context)!.sendRequest,
                    onclick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                          const TrainingPlanScreen(),
                        ),
                      );
                    },
                    textColor: lightPink,
                  )
                      : CustomButton(
                          background: Colors.white,
                          borderColor: lightPink,
                          title: AppLocalizations.of(context)!.sendRequest,
                          onclick: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TrainingPlanScreen(),
                              ),
                            );
                          },
                          textColor: lightPink,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
