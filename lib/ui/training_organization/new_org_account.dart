import 'package:flutter/material.dart';
import 'package:training_app/ui/auth/login_screen.dart';
import 'package:training_app/ui/auth/new_account/second_step.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../style/app_colors.dart';

class SignUpOrganizationScreen extends StatelessWidget {
  const SignUpOrganizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'New Account',
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
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      width: double.infinity,
                      color: lightGrey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            SizedBox(
                              height: 25,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Company Name",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  hintText: 'Company Name',
                                  hintStyle: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 25,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text(
                                    "Email",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 25,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text(
                                    "company information",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
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
                          title: AppLocalizations.of(context)!.register,
                          background: Colors.white,
                          borderColor: lightPink,
                          textColor: lightPink,
                          onclick: () {},
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
