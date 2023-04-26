import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:training_app/controllers/shared_preference_controller.dart';
import 'package:training_app/model/company.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/ui/training_organization/home_organization_screen.dart';
import 'package:training_app/ui/training_organization/main_organization_screen.dart';
import 'package:training_app/ui/training_organization/profile_organization.dart';

import '../ui/student/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

signupCompany(
    {required String info,
    required String email,
    required String password,
    required String name,
    required String interest,
    required String state,
    bool? isFromAdmin,
    required BuildContext context}) {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  )
      .then((user) {
    FirebaseFirestore.instance.collection('users').doc(user.user?.uid).set({
      'email': user.user?.email,
      'info': info,
      'name': name,
      'user_type': '2',
      'image': '',
      'interest':interest,
      'state':state,
      'count':'0'
    }).then((value) async {
      await SharedPreferencesHelper.sharedPreferences!.setString('name', name);
      await SharedPreferencesHelper.sharedPreferences!
          .setString('uid', user.user!.uid);
      await SharedPreferencesHelper.sharedPreferences!.setString('info', info);
      await SharedPreferencesHelper.sharedPreferences!
          .setString('email', email);
      if (isFromAdmin == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم اضافة الشركة")));
        Navigator.pop(context);

      }else{
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainOrganizationScreen(),
          ),
        );
      }

    });
  }).catchError((error) {
    print(error.toString());
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: Text(AppLocalizations.of(context)!.errorSignUpCompany),
      ),
    );
  });
}

Future<File?> pickCompanyPhoto(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    final xFile = result.files.first;
    if (xFile.extension != "png" &&
        xFile.extension != "jpeg" &&
        xFile.extension != 'jpg') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار ملف بصيغة png , jpg'),
        ),
      );
    } else {
      File file = File(result.files.single.path!);

      return file;
    }
  } else {
    return null;
  }
}

Future<bool?> updateProfile(
    {File? image,
    required String info,
    required String name,
    required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  print(id);
  if (image != null) {
    final _firebaseStorage = FirebaseStorage.instance;
    var snapshot =
        await _firebaseStorage.ref().child('file/${image.path}').putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    print('url+$downloadUrl');

    final docRef = FirebaseFirestore.instance.collection('users').doc(id);
    await docRef.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        snapshot.reference.update({
          'info': info,
          'image': downloadUrl,
          'name': name,
          // 'phone': '1234567890'
        }).then((value) async {
          await SharedPreferencesHelper.sharedPreferences!
              .setString('image', downloadUrl);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("تم التحديث بنجاح")));

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileOrganization(),
            ),
          );
        });
      }
    });
  } else {
    final docRef = FirebaseFirestore.instance.collection('users').doc(id);
    await docRef.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        snapshot.reference.update({
          'info': info,
          'name': name,
          // 'phone': '1234567890'
        }).then((value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("تم التحديث بنجاح")));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileOrganization(),
            ),
          );
        });
      }
    });
  }
}

validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

Future sendCompanyRequest({
  required BuildContext context,
  required String link,
  required String address,
  required String name,
  required String image,
  required LatLng location,
  required String number,

}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  var name = SharedPreferencesHelper.sharedPreferences!.getString('name');
  await FirebaseFirestore.instance.collection('companyRequests').add({
    'address': address,
    'link': link,
    'image': image,
    'name': name,
    'latitude': location.latitude,
    'longitude': location.longitude,
    'status': '0',
    'id': id,
    'number':number,
    'Saved_by': [],
    'applied_by': [],
  }).then((value) async {
    await FirebaseFirestore.instance.collection("locations").add({
      'id': value.id,
      "latitude": location.latitude,
      "longitude": location.longitude,
    });

    pushNotificationToAdmin(name: name ?? "");
    addSendRequestNotifications();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم ارسال الطلب بنجاح"),
      ),
    );
  }).onError((error, stackTrace) {
    print(error.toString());
    print(stackTrace.toString());
  });
}

Future<List<CompanyRequest>> getCompanyRequests() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  List<CompanyRequest> companyRequest = [];
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i.data()['id'] == id) {
        print(i.id);
        companyRequest.add(
          CompanyRequest.fromJson(i.data(), i.id),
        );
      }
    }
  });
  return companyRequest;
}

Future<List<String>> getNotification() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  List<String> arrayField = [];
  await FirebaseFirestore.instance
      .collection("notifications")
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i.id == id) {
        arrayField = i.get('notification').cast<String>().toList();
      }
    }
  });
  return arrayField;
}

addSendRequestNotifications() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  await FirebaseFirestore.instance.collection("notifications").doc(id).set({
    'notification': FieldValue.arrayUnion(
      ['send'],
    ),
  }, SetOptions(merge: true));
}

pushNotificationToAdmin({
  required String name,
}) async {
  await FirebaseFirestore.instance.collection("adminNotification").add(
    {
      'title': "$name send request",
    },
  );
}
