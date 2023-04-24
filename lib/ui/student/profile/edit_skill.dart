import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/student_controller.dart';

import '../../../controllers/shared_preference_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditSkills extends StatefulWidget {
  EditSkills({Key? key}) : super(key: key);

  @override
  State<EditSkills> createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {
  TextEditingController skillController = TextEditingController();
  void initState() {
    getUserData();
    super.initState();
  }
  Student? student;
  getUserData() async {
    String? uid=  SharedPreferencesHelper.sharedPreferences!
        .getString('uid');

    if(uid!=null){
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
        student = Student.fromJson(value.data()!);
        if(student!=null){
          skillController.text=student!.skill;
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
                  children:  [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                    Spacer(),
                    Text(
                     AppLocalizations.of(context)!.skills,
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
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
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text("Your Skills"),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              child: TextFormField(
                                controller: skillController,
                                maxLines: 5,
                                decoration:  InputDecoration(
                                  filled: true,
                                  labelText: AppLocalizations.of(context)!.writeHere,
                                  fillColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2,
                      right: 100,
                      left: 100,
                      child: SizedBox(
                        child: CustomButton(
                          title: AppLocalizations.of(context)!.save,
                          background: Colors.white,
                          borderColor: lightPink,
                          textColor: lightPink,
                          onclick: () {
                            if (skillController.text.isNotEmpty) {
                              updateSkill(
                                  skill: skillController.text, context: context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('يرجى ادخال الحقل المطلوب')));
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
