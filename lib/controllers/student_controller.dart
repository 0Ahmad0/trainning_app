import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/shared_preference_controller.dart';
import 'package:training_app/model/question.dart';
import 'package:training_app/model/student.dart';
import 'package:training_app/ui/student/main_screen.dart';
import '../model/Faq.dart';
import '../model/comment.dart';
import '../model/company.dart';
import '../model/company_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class StudentController{
  static Student student=Student();
}
Future<List<Question>> getChatBootQuestion() async {
  List<Question> questionList = [];
  await FirebaseFirestore.instance.collection("FAQ").get().then((value) {
    for (var i in value.docs) {
      questionList.add(Question.fromJson(i.data()));
    }
  });
  return questionList;
}
///
Future<List<CategoryQue>> getCategoryQuestion() async {
  List<CategoryQue> categoryQue = [];
  await FirebaseFirestore.instance.collection("Category_FAQ").get().then((value) {
    for (var i in value.docs) {
      categoryQue.add(CategoryQue.fromJson(i.data()));
    }
  });
  return categoryQue;
}
Future<List<QuestionCate>> getQuestion({required String id }) async {
  List<QuestionCate> que = [];
  await FirebaseFirestore.instance.collection("Category_FAQ").
  doc(id).
  collection("Questions")
      .get().then((value) {
    for (var i in value.docs) {
      print("i.id");
      que.add(QuestionCate.fromJson(i.data()));
    }

  });
  return que;
}
///

editUserInfo(
    {required String name,
    required String phone,
    required BuildContext context}) async {
  var id = await SharedPreferencesHelper.sharedPreferences!.getString('uid');
  final docRef = FirebaseFirestore.instance.collection('users').doc(id);
  await docRef.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      snapshot.reference.update({
        'name': name,
        'phone': phone,
        // 'phone': '1234567890'
      }).then((value) {
        StudentController.student.name=name;
        StudentController.student.phone=phone;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.successfullyUpdate)));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      });
    }
  });
}

editPersonalInfo({
  required String dob,
  required String city,
  required String nationality,
  required String gender,
  required BuildContext context,
}) async {
  var id = await SharedPreferencesHelper.sharedPreferences!.getString('uid');
  final docRef = FirebaseFirestore.instance.collection('users').doc(id);
  await docRef.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      snapshot.reference.update({
        'dob': dob,
        'city': city,
        'nationality': nationality,
        'gender': gender
        // 'phone': '1234567890'
      }).then((value) {
        StudentController.student.dob=dob;
        StudentController.student.city=city;
        StudentController.student.nationality=nationality;
        StudentController.student.gender=gender;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.successfullyUpdate)));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      });
    }
  });
}

updateSkill({
  required String skill,
  required BuildContext context,
}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  final docRef = FirebaseFirestore.instance.collection('users').doc(id);
  await docRef.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      snapshot.reference.update({
        'skill': skill,
        // 'phone': '1234567890'
      }).then((value) {
        StudentController.student.skill=skill;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.successfullyUpdate)));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      });
    }
  });
}

updateLanguage(
    {required String level,
    required String language,
    required String other,
    required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  final docRef = FirebaseFirestore.instance.collection('users').doc(id);
  await docRef.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      snapshot.reference.update({
        'level': level,
        'language': language,
        'other': other,
        // 'phone': '1234567890'
      }).then((value) {
        StudentController.student.level=level;
        StudentController.student.language=language;
        StudentController.student.other=other;
        ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(content: Text(AppLocalizations.of(context)!.successfullyUpdate)));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      });
    }
  });
}

Future<File?> pickFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final xFile = result.files.first;
    if (xFile.extension != "pdf") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار ملف بصيغة pdf'),
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

Future<bool?> uploadFile(
    {required File file,
    required String name,
    required String interest,
      required String state,
    required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  var name = SharedPreferencesHelper.sharedPreferences!.getString('name');
  final _firebaseStorage = FirebaseStorage.instance;
  var snapshot =
      await _firebaseStorage.ref().child('file/${file.path}').putFile(file);
  var downloadUrl = await snapshot.ref.getDownloadURL();
  print('url+$downloadUrl');
  FirebaseFirestore.instance.collection('StudentsRequests').doc(id).set({
    'file': downloadUrl,
    'name': name,
    'interest': interest,
    'status': '0',
    'state':state,
    'id': id,
  }).then((value) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(id);
    await docRef.update({
      'isSendRequest': '2',
      'exp':downloadUrl,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("تم ارسال الخطة بنجاح"),
        ),
      );
      addSendRequestNotifications();
      pushNotificationFromStudentToAdmin(name: name??"");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    });
    await SharedPreferencesHelper.sharedPreferences!
        .setString('isSendRequest', "2");
  });
}

Future<List<CompanyRequest>> getCompanyToStudent() async {
  List<CompanyRequest> companyRequest = [];
  List<Company> company = [];

  await FirebaseFirestore.instance
      .collection("companyRequests")
    //  .collection("users")
      .get()
      .then((value) {
    for (var i in value.docs) {
      //print(i.id);

      if (i['status'] == '2') {
      //if (i['user_type'] == '2'&&i['state']==StudentController.student.state) {
       // company.add(
        companyRequest.add(
          CompanyRequest.fromJson(
         // Company.fromJson(
            i.data(),
            i.id,
          ),
        );
      }
    }
  });

  return companyRequest;
 // return company;
}

sendComment(
    {required String comment,
    required String id,
    required String name,
    required BuildContext context}) async {
  await FirebaseFirestore.instance.collection('comments').add({
    'id': id,
    'name': name,
    'comment': comment,
  }).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم ارسال التعليق بنجاح"),
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  });
}

Future<List<CommentModel>> getComments({required String id}) async {
  List<CommentModel> commentsList = [];
  await FirebaseFirestore.instance.collection("comments").get().then((value) {
    for (var i in value.docs) {
      if (i.data()['id'] == id) {
        commentsList.add(
          CommentModel.fromJson(
            i.data(),
          ),
        );
      }
    }
  });
  return commentsList;
}

saveJob({required String companyId, required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .doc(companyId)
      .update({
    'Saved_by': FieldValue.arrayUnion([id]),
  }).then((value) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('تم الحفظ')));
  });
}

Future<List<CompanyRequest>> getSaved() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  List<CompanyRequest> companyRequest = [];

  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      List<dynamic> arrayField = i.get('Saved_by');
      if (arrayField.contains(id)) {
        // print(id);
        companyRequest.add(
          CompanyRequest.fromJson(
            i.data(),
            i.id,
          ),
        );
      }
    }
  });
  return companyRequest;
}

addApplicant({required String companyId, required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .doc(companyId)
      .update({
    'applied_by': FieldValue.arrayUnion([id]),
  });
}

Future<List<CompanyRequest>> getAppliedCompany() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  List<CompanyRequest> companyRequest = [];
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      List<dynamic> arrayField = i.get('applied_by');
      if (arrayField.contains(id)) {
        companyRequest.add(
          CompanyRequest.fromJson(
            i.data(),
            i.id,
          ),
        );
      }
    }
  });
  return companyRequest;
}

addSendRequestNotifications() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  await FirebaseFirestore.instance.collection("notifications").doc(id).set({
    'notification': FieldValue.arrayUnion(
      ['send'],
    ),
  }, SetOptions(merge: true));
}

Future<List<String>> getNotification() async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
  List<String> arrayField = [];

  await FirebaseFirestore.instance
      .collection("notifications")
      .get()
      .then((value) {
    for (var i in value.docs) {
      print(id);
      if (i.id == id) {
        arrayField = i.get('notification').cast<String>().toList();

      }
    }
  });
  return arrayField;
}
pushNotificationFromStudentToAdmin({required String name,}) async {
  await FirebaseFirestore.instance.collection("adminNotification").add({
    'title':"$name send request",
  }, );
}
Future<CompanyRequest?> getCompanyOffer({required String company}) async {
  print("in method");
  print(company);
  CompanyRequest? companyRequest;
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      print(i.id);
      if (i['id'] == company) {
        companyRequest=  CompanyRequest.fromJson(
          i.data(),
          i.id,
        );

      }
    }


  });

  return companyRequest;
}
Future<File?> pickStudentPhoto(BuildContext context) async {
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
Future<bool?> updateStudebtProfile(
    {File? image,
      required BuildContext context}) async {
  var id = SharedPreferencesHelper.sharedPreferences!.getString('uid');
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
          'img': downloadUrl,
          // 'phone': '1234567890'
        }).then((value) async {
          StudentController.student.img=downloadUrl;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("تم التحديث بنجاح")));
          Navigator.of(context).pop();
          Navigator.of(context).pop();

        });
      }
    });
  }
}