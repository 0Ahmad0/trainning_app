import 'package:flutter/material.dart';

import '../../controllers/auth_controllers.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children:  [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 10,
                            color: Colors.white,
                          ),
                          Text(
                            AppLocalizations.of(context)!.home,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                     Text(
                       AppLocalizations.of(context)!.changePassword,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Spacer(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                controller: newPasswordController,
                                decoration:  InputDecoration(
                                    hintText:   AppLocalizations.of(context)!.newPassword,
                                    hintStyle: TextStyle(fontSize: 12),
                                    suffixIcon:
                                        Icon(Icons.remove_red_eye_outlined)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextFormField(
                                controller: confirmPasswordController,
                                decoration:  InputDecoration(
                                    hintText:   AppLocalizations.of(context)!.confirmNewPassword,
                                    hintStyle: TextStyle(fontSize: 12),
                                    suffixIcon:
                                        Icon(Icons.remove_red_eye_outlined)),
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
                          title:   AppLocalizations.of(context)!.save,
                          background: Colors.white,
                          borderColor: lightPink,
                          textColor: lightPink,
                          onclick: () {
                            if (newPasswordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('كلمات المرور غير متطابقة'),
                                ),
                              );
                            } else if (newPasswordController.text.isEmpty |
                                confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى ادخال الحقول المطلوبة'),
                                ),
                              );
                            } else {
                              changePassword(
                                  newPasswordController.text, context);
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
