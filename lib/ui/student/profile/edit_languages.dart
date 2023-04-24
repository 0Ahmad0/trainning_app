import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/student_controller.dart';

import '../../../controllers/shared_preference_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditLanguages extends StatefulWidget {
  EditLanguages({Key? key}) : super(key: key);

  @override
  State<EditLanguages> createState() => _EditLanguagesState();
}

class _EditLanguagesState extends State<EditLanguages> {
  var items = [
    'level 1',
    'level 2',
    'level 3',
  ];

  String dropdownLevelValue = 'level 1';

  var itemsLanguge = [
    'Arabic',
    'English',
  ];

  String dropdownLanguageValue = 'Arabic';

  TextEditingController otherController = TextEditingController();
  void initState() {
    getUserData();
    super.initState();
  }
  Student? student;
  getUserData() async {
    String? uid=  SharedPreferencesHelper.sharedPreferences!
        .getString('uid');
    print(uid);
    if(uid!=null){
      FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
        student = Student.fromJson(value.data()!);
        if(student!=null){
          otherController.text =student!.other;
          if(student!.level!=''){
            dropdownLevelValue=student!.level;
            setState(() {

            });
          }if(student!.language!=''){
            dropdownLanguageValue=student!.language;
            setState(() {

            });
          }
        }
      });
    }
    setState(() {

    });
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
                        AppLocalizations.of(context)!.language,
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
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
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("Proficiency level"),
                            SizedBox(
                              height: 30,
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                // Initial Value
                                value: dropdownLevelValue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownLevelValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('languages'),
                            SizedBox(
                              height: 35,
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                // Initial Value
                                value: dropdownLanguageValue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: itemsLanguge.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownLanguageValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Other'),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                controller:otherController ,
                                decoration: const InputDecoration(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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

                            if (otherController.text.isNotEmpty) {
                              updateLanguage(
                                  level: dropdownLevelValue,
                                  language: dropdownLanguageValue,
                                  other: otherController.text,
                                  context: context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('يرجى تعبئة كل الحقول')));
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
