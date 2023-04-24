import 'package:flutter/material.dart';
import 'package:training_app/ui/auth/forget_password.dart';
import '../../controllers/auth_controllers.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'new_account/signup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

bool _passwordVisible =false;
  bool _obscureText = true;
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
                              padding: EdgeInsets.only(right: 50),
                              child: Image.asset('assets/entern_logo.png')),
                          Text(
                            'Welcome Back',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    right: 30,
                    left: 30,
                    child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: TextFormField(
                                    controller: emailController,
                                    decoration:  InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                          size: 20,
                                        ),
                                        hintText:AppLocalizations.of(context)!.email,
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
                                    obscureText: _obscureText,


                                    decoration:  InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        size: 20,
                                      ),
                                      suffix: IconButton(
                                    icon: Icon(
                                    _obscureText
                                    ? Icons.visibility
                                      : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),

                                      hintText: AppLocalizations.of(context)!.password,
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 4.7,
                            right: 90,
                            left: 90,
                            child: Column(
                              children: [
                                CustomButton(
                                  title: AppLocalizations.of(context)!.login,
                                  background: const Color(0xffD59EA6),
                                  borderColor: lightPink,
                                  onclick: () {
                                    signInWithEmailAndPassword(emailController.text,
                                        passwordController.text, context);
                                  },
                                ),
                                InkWell(
                                  onTap: (){
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ForgetPassword()));
                                  },
                                    child: Text(AppLocalizations.of(context)!.forgetPassword,style: TextStyle(fontSize:12),)),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context)!.doNotHaveAnAccount),
                  Spacer(),
                  SizedBox(
                    width: 100,
                    child: CustomButton(
                      title: AppLocalizations.of(context)!.register,
                      background: Colors.white,
                      borderColor: lightPink,
                      textColor: lightPink,
                      onclick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
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
