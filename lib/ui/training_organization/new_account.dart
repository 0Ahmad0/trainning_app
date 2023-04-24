import 'package:flutter/material.dart';
import '../../controllers/company_controller.dart';
import '../../style/app_colors.dart';
import '../auth/new_account/second_step.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewOrganizationAccount extends StatelessWidget {
  NewOrganizationAccount({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).pop();
                     },
                     child: const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                  ),
                   ),
                  Spacer(),
                   Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                    AppLocalizations.of(context)!.createAccount,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Container(
                      width: 120,
                      height: 50,
                      padding: EdgeInsets.only(right: 50),
                      child: Image.asset('assets/entern_logo.png')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: double.infinity,
                    color: lightGrey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(AppLocalizations.of(context)!.companyName),
                          SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Text(AppLocalizations.of(context)!.email),
                          SizedBox(
                            height: 25,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Text(AppLocalizations.of(context)!.password),
                          SizedBox(
                            height: 25,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(AppLocalizations.of(context)!.companyInformations),
                          SizedBox(
                            height: 25,
                            child: TextFormField(
                              controller: infoController,
                              decoration: const InputDecoration(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: CustomButton(
                                title: AppLocalizations.of(context)!.register,
                                background: Colors.white,
                                borderColor: lightPink,
                                textColor: lightPink,
                                onclick: () {
                                  if (nameController.text.isEmpty |
                                      passwordController.text.isEmpty |
                                      infoController.text.isEmpty |
                                      passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('يرجى ادخال جميع الحقول'),
                                      ),
                                    );
                                  }else{

                                    signupCompany(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                        info: infoController.text,
                                        name: nameController.text);
                                  }

                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
