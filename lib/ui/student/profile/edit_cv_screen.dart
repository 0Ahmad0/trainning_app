import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/shared_preference_controller.dart';
import '../../../controllers/student_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';

class TrainingPlanScreen extends StatefulWidget {
  const TrainingPlanScreen({Key? key}) : super(key: key);

  @override
  State<TrainingPlanScreen> createState() => _TrainingPlanScreenState();
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  int buttonTitle = 1;
  File? file;
  bool? isLoading=false;
  String? name;
  String? interest;
  String? isSendRequest;

  @override
  void initState() {
    super.initState();
    name = SharedPreferencesHelper.sharedPreferences!.getString('name');
    interest = SharedPreferencesHelper.sharedPreferences!.getString('interest');
    getUserData();
  }
 bool isHavExp=false;
  Student? student;
  getUserData() async {
    String? uid=  SharedPreferencesHelper.sharedPreferences!
        .getString('uid');
    print(uid);
    if(uid!=null){
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
        student = Student.fromJson(value.data()!);
         if(student!.exp!=""){
           isHavExp = true;
           setState(() {

           });
         }
      });
    }
    setState(() {

    });
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
                children:  [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                   Text(
                    AppLocalizations.of(context)!.experience,
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          isLoading== true?const LinearProgressIndicator(color: darkPurple,backgroundColor: lightPurple,):SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Stack(
                children: [
                   Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: double.infinity,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.uploadYouExperience,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 1.9,
                    right: 100,
                    left: 100,
                    child: SizedBox(
                      child: CustomButton(
                              title:buttonTitle==1 ?"Pick File":"Upload",
                              background: Colors.white,
                              borderColor: lightPink,
                              textColor: lightPink,
                              onclick: () {
                                if (buttonTitle == 1) {
                                  pickFile(context).then((value) {
                                    if (value != null) {
                                      buttonTitle = 2;
                                      setState(() {
                                        file = value;
                                      });
                                    }
                                  });
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  uploadFile(
                                      file: file!,
                                      name: name ?? "",
                                      interest: interest ?? "",
                                    context: context
                                  ).then((value){
                                   setState(() {
                                     isLoading=false;
                                   });
                                  });
                                }
                              },
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              if(file!=null){
                OpenFile.open(file!.path);

              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لم يتم اختيار  ملف')));
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 15,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightGrey,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "File",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height / 20,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lightGrey,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
void launchPDFUrl( { required String url}) async {

  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
