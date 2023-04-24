import 'package:flutter/material.dart';
import 'package:training_app/ui/auth/new_account/verify_code_screen.dart';

import '../../../controllers/auth_controllers.dart';
import '../../../model/student.dart';
import '../../../style/app_colors.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberStep extends StatelessWidget {
  PhoneNumberStep({Key? key, required this.newStudent}) : super(key: key);
  final Student newStudent;
  TextEditingController phoneController = TextEditingController();

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
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.close,
                      size: 20,
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
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20, top: 15, left: 20),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    AppLocalizations.of(context)!.phoneNumber,
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 50,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabled: false,
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: '+966'),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 12),
                              hintText:
                                  AppLocalizations.of(context)!.phoneNumber,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: 120,
                      height: 30,
                      child: CustomButton(
                        borderColor: lightPink,
                        background: Colors.white,
                        title: AppLocalizations.of(context)!.register,
                        textColor: lightPink,
                        onclick: () {
                          AuthController().verifyPoneNumber(context,
                              "+966${phoneController.text}", newStudent);
                          /* Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  VerifyCodeScreen(),
                          ),
                        );*/
                        },
                      ),
                    ),
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
