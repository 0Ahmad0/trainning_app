import 'package:flutter/material.dart';
import 'package:training_app/ui/auth/login_screen.dart';
import 'package:training_app/ui/auth/new_account/second_step.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controllers/company_controller.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../onBoarding/onboarding_screen.dart';
import '../../training_organization/new_account.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController SurepasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              lightPurple,
                              lightPink,
                              lightYallow,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                              bottomRight: Radius.circular(45))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150,
                              padding: const EdgeInsets.only(right: 50),
                              child: Image.asset('assets/entern_logo.png')),
                          Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    right: 30,
                    left: 30,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 4,
                            // width: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                          size: 20,
                                        ),
                                        hintText:
                                            AppLocalizations.of(context)!.email,
                                        hintStyle: TextStyle(fontSize: 12)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 25,
                                  child: TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        size: 20,
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .password,
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 25,
                                  child: TextFormField(
                                    controller: SurepasswordController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        size: 20,
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .confirmPassword,
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.byClicking,
                                  style: TextStyle(
                                    fontSize: 8,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 4.7,
                            right: 90,
                            left: 90,
                            child: CustomButton(
                              title: AppLocalizations.of(context)!.next,
                              background: Color(0xffD59EA6),
                              borderColor: lightPink,
                              onclick: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty&&
                                SurepasswordController.text.isNotEmpty&&(
                                    passwordController.text== SurepasswordController.text)


                                ) {
                                  Student newUser = Student(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.membershipType,
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                const Divider(
                                                  color: darkPink,
                                                  thickness: 1,
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                MemberNameWidget(
                                                  title: AppLocalizations.of(context)!.student,
                                                  nextScreen:  SecondStep(
                                                    newStudent: newUser,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                MemberNameWidget(
                                                  title:AppLocalizations.of(context)!.company,
                                                  nextScreen:
                                                  NewOrganizationAccount(),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },);
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => SecondStep(
                                  //       newStudent: newUser,
                                  //     ),
                                  //   ),
                                  // );
                                } else if (validateEmail(emailController.text) ==
                                    false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('يرجى ادخال بريد الكترني صالح'),
                                    ),
                                  );
                                }else if(passwordController.text!= SurepasswordController.text){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'يجب ان تتطابق كلمة المرور مع تأكيد كلمة المرور'),
                                    ),
                                  );

                                }


                                else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'يرجى ادخال البريد الالكتروني وكلمة المرور'),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.haveAccount,
                  ),
                  Spacer(),
                  CustomButton(
                    title: AppLocalizations.of(context)!.login,
                    background: Colors.white,
                    borderColor: lightPink,
                    textColor: lightPink,
                    onclick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
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
