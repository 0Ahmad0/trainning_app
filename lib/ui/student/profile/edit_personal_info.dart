import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../controllers/shared_preference_controller.dart';
import '../../../controllers/student_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPersonalInfo extends StatefulWidget {
  EditPersonalInfo({Key? key}) : super(key: key);

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  TextEditingController dateController = TextEditingController();
  var itemsNationalty = [
    'Saudi',
    'other',
  ];
  String dropdownNationaltyValue = 'Saudi';
  String dropdownGenderValue = 'male';
  var itemsGender = [
    'male',
    'female',
  ];

  var itemsCity = [
    'Jada',
    'Dammam',
  ];
  String dropdownCityValue = 'Jada';
@override
  void initState() {
  getUserData();
    super.initState();
  }
  Student? student;
  getUserData() async {
   String? uid=  SharedPreferencesHelper.sharedPreferences!
        .getString('uid');
   print('uid,uid');
   print(uid);
   if(uid!=null){
     FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
       student = Student.fromJson(value.data()!);
       if(student!=null){
         dateController.text=student!.dob;
        if(student!.city!=''){
          dropdownCityValue=student!.city;
          setState(() {

          });
        }if(student!.gender!=''){
           dropdownGenderValue=student!.gender;
           setState(() {

           });
         }if(student!.nationality!=''){
          dropdownNationaltyValue=student!.nationality;
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
                      AppLocalizations.of(context)!
                          .editPersonalInfo,
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
                height: MediaQuery.of(context).size.height,
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
                             Text(AppLocalizations.of(context)!.dob),
                            SizedBox(
                              height: 25,
                              child: TextFormField(
                                controller: dateController,
                                decoration: const InputDecoration(
                                  hintText: 'DD/MM/YYYY',
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('City'),
                            SizedBox(
                              height: 30,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                // Initial Value
                                value: dropdownCityValue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: itemsCity.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownCityValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Nationality'),
                            SizedBox(
                              height: 35,
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                // Initial Value
                                value: dropdownNationaltyValue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: itemsNationalty.map((String items) {
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
                                    dropdownNationaltyValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Gender'),
                            SizedBox(
                              height: 30,
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                // Initial Value
                                value: dropdownGenderValue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: itemsGender.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownGenderValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
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
                            if (dateController.text.isNotEmpty) {
                              editPersonalInfo(
                                  context: context,
                                  nationality: dropdownNationaltyValue,
                                  gender: dropdownGenderValue,
                                  dob: dateController.text,
                                  city: dropdownCityValue);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("يرجى ادخال تاريخ الميلاد")));
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
