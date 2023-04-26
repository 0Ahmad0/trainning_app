import 'dart:io';

import 'package:flutter/material.dart';
import 'package:training_app/ui/widgets/custom_button.dart';

import '../../../controllers/company_controller.dart';
import '../../../controllers/shared_preference_controller.dart';
import '../../../controllers/student_controller.dart';
import '../../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  var email ="";
  var name ="";
  var img ="";
@override
  void initState() {
  name = SharedPreferencesHelper.sharedPreferences!.getString("name")!;
  email = SharedPreferencesHelper.sharedPreferences!.getString("email")!;
  img = StudentController.student.img;
  super.initState();

}
  bool isImageSelected = false;
  File? file;
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
                       child: const Icon(
                        Icons.close,
                        size: 20,
                    ),
                     ),
                    Spacer(),
                    Text(
                     AppLocalizations.of(context)!.editProfile,
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      color: lightGrey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            InkWell(
                              onTap:(){
                                pickStudentPhoto(context).then((value) {
                                  if (value != null) {
                                    file = value;
                                    setState(() {
                                      isImageSelected = true;
                                    });
                                  }
                                });
                              },
                              child: isImageSelected==false?(
                                  img!=null? SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(img),
                                      )
                                  )
                                      :
                                      SizedBox(
                                      height: MediaQuery.of(context).size.height / 7,
                                  child: Image.asset('assets/profile_pic.png'),
                                )

                              ):SizedBox(
                                height: 90,
                                width: 90,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(file!),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                 SizedBox(
                                    height: 30, width: 50, child: Text(AppLocalizations.of(context)!.name+":")),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration:  InputDecoration(
                                          hintStyle: TextStyle(fontSize: 12),
                                          hintText: AppLocalizations.of(context)!.name),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          /*  SizedBox(
                              height: 25,
                              child: TextFormField(
                                decoration:  InputDecoration(
                                 *//* label: Text(
                                    AppLocalizations.of(context)!.name,
                                    style: TextStyle(fontSize: 12),
                                  ),*//*
                                  hintText: AppLocalizations.of(context)!.name,
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),*/
                            const SizedBox(
                              height: 20,
                            ),
                             Row(
                               children: [
                                 SizedBox(height: 25, child: Text(AppLocalizations.of(context)!.email+":")),
                                 SizedBox(width: 10,),
                                 Padding(
                                   padding: EdgeInsets.only(top: 8.0),
                                   child: SizedBox(height: 25, child: Text(email)),
                                 ),
                               ],
                             ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                    height: 15, width: 50, child: Text('+966')),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 30,
                                    child: TextFormField(
                                      controller: phoneController,
                                      decoration:  InputDecoration(
                                          hintStyle: TextStyle(fontSize: 12),
                                          hintText: AppLocalizations.of(context)!.phoneNumber),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 2.2,
                      right: 100,
                      left: 100,
                      child: SizedBox(
                        child: CustomButton(
                          title: isImageSelected ==true?AppLocalizations.of(context)!.updateImage:AppLocalizations.of(context)!.save,
                          background: Colors.white,
                          borderColor: lightPink,
                          textColor: lightPink,
                          onclick: () {
                             if(isImageSelected ==true){
                               updateStudebtProfile(context: context,image: file);
                             }else{
                               if (nameController.text.isNotEmpty &&
                                   phoneController.text.isNotEmpty) {
                                 editUserInfo(
                                   name: nameController.text,
                                   phone: phoneController.text,
                                   context: context,);
                               } else {
                                 ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                         content: Text("يرجى ادخال البيانات ")));
                               }
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
