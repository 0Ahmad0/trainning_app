import 'package:flutter/material.dart';

import '../../controllers/auth_controllers.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatelessWidget {
   ForgetPassword({Key? key}) : super(key: key);
TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
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
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 120,
                            padding:  EdgeInsets.only(right: 50),
                            child: Image.asset('assets/entern_logo.png')),
                         Text(
                          AppLocalizations.of(context)!.forgetPassword,
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height/2.3,
                  right: 30,
                  left: 30,
                  child: Container(
                    height:MediaQuery.of(context).size.height/5,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/7 ,
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
                                height: 30,
                                child: TextFormField(
                                  controller: controller,
                                  decoration:  InputDecoration(
                                    hintText: AppLocalizations.of(context)!.email,
                                    hintStyle: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height/9,
                          right: 90,
                          left: 90,
                          child:  CustomButton(
                            title: AppLocalizations.of(context)!.send,
                            background: Color(0xffD59EA6),
                            borderColor: lightPink,
                            onclick: () {
                              if(controller.text.isNotEmpty){
                                resetPassword(context: context,email: controller.text);

                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.fillEmail)));
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
        ],
      ),
    );
  }
}
