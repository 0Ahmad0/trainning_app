import 'package:flutter/material.dart';
import 'package:training_app/controllers/shared_preference_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_app/controllers/student_controller.dart';
import 'package:training_app/model/company.dart';
import 'package:training_app/ui/auth/login_screen.dart';
import 'package:training_app/ui/training_organization/main_organization_screen.dart';
import 'package:training_app/ui/training_unit/training_main_screen.dart';
import '../model/student.dart';
import '../ui/auth/new_account/verify_code_screen.dart';
import '../ui/student/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;
  String? otp, authStatus = "";

  Future<void> verifyPoneNumber(
    BuildContext context,
    String phone,
    Student student,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {
        print("Your account is successfully verified");
      },
      verificationFailed: (authException) {
        print("Authentication failed");
      },
      codeSent: (String verId, int? forceCodeResent) {
        print((verId));
        verificationId = verId;
        print(verificationId.toString() + "verificationId");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(
              verificationId: verificationId!,
              user: student,
            ),
          ),
        );
        print("OTP has been successfully send");
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        print('TIMEOUT');
      },
    );
  }

  signIn(String otp, BuildContext context, String verificationId,
      Student student) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    ))
        .then((value) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: student.email!,
        password: student.password!,
      ).then((user) async {
        FirebaseFirestore.instance.collection('users').doc(user.user?.uid).set({
          'email': user.user?.email,
          'phone': student.phone,
          'interest': student.interest,
          'name': student.name,
          'user_type':'1',
          'level':"",
          'language':"",
          "other":"",
          "skill":"",
          "dob":"",
          "city":"",
          "nationality":"",
          "gender":"",
          "exp":"",
          "img":""
        }).then((value) async {
          print(student.name);
          print(student.email);
          await SharedPreferencesHelper.sharedPreferences!
              .setString('name', student.name);
          await SharedPreferencesHelper.sharedPreferences!
              .setString('email', student.email??"");
        });

      }).catchError((error) {
        print(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSignUp),
          ),
        );
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ),
      );
    });
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (result.user != null) {
      User user = result.user!;
      await SharedPreferencesHelper.sharedPreferences!
          .setString('uid', user.uid.toString());
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid.toString())
          .get()
          .then((value) async {
            print(value.data());
        if (value.exists) {
          if (value['user_type'] == '1') {
            Student student = Student.fromJson(value.data()!);
            StudentController.student=student;
            await SharedPreferencesHelper.sharedPreferences!
                .setString('name', student.name);
            await SharedPreferencesHelper.sharedPreferences!
                .setString('email', email);
            await SharedPreferencesHelper.sharedPreferences!
                .setString('interest', student.interest);
            print(student.name);
            print("student.name");
            print(email);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          } else if(value['user_type'] == '2'){
            Company company = Company.fromJson(value.data()!,value.id);
            await SharedPreferencesHelper.sharedPreferences!
                .setString('nameCom', company.name);
            /*await SharedPreferencesHelper.sharedPreferences!
                 .setString('emailCom', company.email);*/
            await SharedPreferencesHelper.sharedPreferences!
                .setString('info', company.info);
            await SharedPreferencesHelper.sharedPreferences!
                .setString('image', company.image);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MainOrganizationScreen(),
              ),
            );
          }else {
            await SharedPreferencesHelper.sharedPreferences!
                .setString('name', value['name']);
            await SharedPreferencesHelper.sharedPreferences!
                .setString('email', value['email']);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TrainingMainScreen(),
              ),
            );
          }
        }
      });
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(AppLocalizations.of(context)!.enterCorrectDate),
        ),
      );
    }
    // User signed in successfully, you can now retrieve user data from your database
  } catch (e) {
   // print(e.toString());
    print("failed");
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(AppLocalizations.of(context)!.enterCorrectDate),
      ),
    );
  }
}

changePassword(String newPassword, BuildContext context) async {
  User user = FirebaseAuth.instance.currentUser!;
  user.updatePassword(newPassword).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(AppLocalizations.of(context)!.successChangePassword),
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }).catchError((error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(AppLocalizations.of(context)!.failedChangePassword),
      ),
    );
  });
}

logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut().then((_) async {
    await SharedPreferencesHelper.sharedPreferences!
        .setString('name', "");
    await SharedPreferencesHelper.sharedPreferences!
        .setString('email', "").then((value){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });

  }).catchError((error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logout failed"),
      ),
    );
    //print("Logout failed: $error");
  });
}
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> resetPassword({required BuildContext context ,required String email}) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.reViewEmail)));
  } catch (e) {
    print("faild");
    print(e.toString());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

  }
}

