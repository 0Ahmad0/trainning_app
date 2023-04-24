import 'package:flutter/material.dart';
import 'package:training_app/model/student.dart';
import 'package:training_app/style/app_colors.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:training_app/controllers/auth_controllers.dart'as controller;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controllers/auth_controllers.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({Key? key,required this.verificationId,required this.user}) : super(key: key);
  TextEditingController codeController = TextEditingController();
  String verificationId;
  Student user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                child: Image.asset('assets/verify_image.png'),
              ),
            ),
             Text(
               AppLocalizations.of(context)!.pleaseVerify,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                controller: codeController,
                  decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),),
            ),
            /*    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 40,
                  child: TextFormField(
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  height: 40,
                  child: TextFormField(
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  height: 40,
                  child: TextFormField(
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50,
                  height: 40,
                  child: TextFormField(
                      decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),*/
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Please enter the verification code sent',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            SizedBox(
              width: 120,
              height: 35,
              child: CustomButton(
                title: "check",
                background: darkPink,
                borderColor: darkPink,
                onclick: () {
                  AuthController().signIn(codeController.text,context,verificationId,user);
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
