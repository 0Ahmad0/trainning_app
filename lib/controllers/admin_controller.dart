import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/shared_preference_controller.dart';
import 'package:training_app/model/student_request.dart';
import 'package:training_app/ui/training_unit/training_main_screen.dart';

import '../model/company_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<List<StudentRequest>> getStudentsPendingRequest() async {
  List<StudentRequest> studentRequestList = [];
  await FirebaseFirestore.instance
      .collection("StudentsRequests")
      .where("status", isEqualTo: '0')
      .get()
      .then((value) {
    print(value.docs.length.toString() + "length");
    for (var i in value.docs) {
      studentRequestList.add(
        StudentRequest.fromJson(
          i.data(),
        ),
      );
    }
  });
  return studentRequestList;
}

Future<List<StudentRequest>> getAllStudentsRequests() async {
  List<StudentRequest> studentRequestList = [];

  await FirebaseFirestore.instance
      .collection("StudentsRequests")
      .get()
      .then((value) {
    print(value.docs.length.toString() + "len85555gth");
    for (var i in value.docs) {
      if (i.data()['status'] != '0') {
        studentRequestList.add(
          StudentRequest.fromJson(
            i.data(),
          ),
        );
      }
    }
  });
  return studentRequestList;
}

Future<List<CompanyRequest>> getCompanyRequestsToAdmin() async {
  List<CompanyRequest> companyRequest = [];
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    print(value.docs.length.toString() + "list request company");
    for (var i in value.docs) {
      print(i.id);
      print("i.id");
      if(i['status']=='0'){
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
Future<List<CompanyRequest>> getCompanyStatusRequestsToAdmin() async {
  List<CompanyRequest> companyRequest = [];
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      print(i.id);
      print("i.id");
      if(i['status']!='0'){
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

/*
Future<List<CompanyRequest>> getCompanyRequestsToAdmin()async{
  List<CompanyRequest> requestList = [];

   var userRef = FirebaseFirestore.instance.collection("CompanyRequests").doc().collection("requests");
  userRef.get().then(( value) {
    print(value);
    print("requestList.length");
print(value.docs.length);
    for (var i in value.docs) {
      requestList.add(CompanyRequest.fromJson(i.data()));
      print(requestList.length);
    }
  });
  return requestList;
}
*/
acceptRequest(String id, BuildContext context) async {
  await FirebaseFirestore.instance
      .collection("StudentsRequests")
      .where("id", isEqualTo: id)
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i.id == id) {
        FirebaseFirestore.instance
            .collection("StudentsRequests")
            .doc(id)
            .update({"status": '2'});
        break;
      }
    }
    addAcceptRequestNotifications(studentId: id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.acceptReq)));
  });
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const TrainingMainScreen(),
    ),
  );
}

acceptCompanyRequest(String id, BuildContext context,) async {

  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i.id == id) {
        FirebaseFirestore.instance
            .collection("companyRequests")
            .doc(id)
            .update({"status": '2'});
        break;
      }
    }
    addAcceptRequestNotificationsToCompany(companyId: id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.acceptReq)));
  });
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const TrainingMainScreen(),
    ),
  );
}

rejectRequest(String id, BuildContext context) async {
  await FirebaseFirestore.instance
      .collection("StudentsRequests")
      .where("id", isEqualTo: id)
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i.id == id) {
        FirebaseFirestore.instance
            .collection("StudentsRequests")
            .doc(id)
            .update({"status": '1'});
        break;
      }
    }
    addRejectRequestNotificationsToCompany(companyId: id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.rejectReq)));
  });
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const TrainingMainScreen(),
    ),
  );
}

rejectCompanyRequest(String id, BuildContext context) async {
  await FirebaseFirestore.instance
      .collection("companyRequests")
      .get()
      .then((value) {
    for (var i in value.docs) {
      if (i['id'] == id) {
        FirebaseFirestore.instance
            .collection("companyRequests")
            .doc(id)
            .update({"status": '1'});
        break;
      }
    }
  });
    addRejectRequestNotificationsToCompany(companyId: id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم رفض الطلب '),
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TrainingMainScreen(),
      ),
    );

  }



addAcceptRequestNotificationsToStudent({required String studentId})async{
  await FirebaseFirestore.instance
      .collection("notifications")
      .doc(studentId)
      .update({
    'notification': FieldValue.arrayUnion(['accept']),
  });
}
addAcceptRequestNotifications({ required String studentId}) async {
  await FirebaseFirestore.instance.collection("notifications").doc(studentId).set({
    'notification': FieldValue.arrayUnion(
      ['accept'],
    ),
  }, SetOptions(merge: true));
}
addAcceptRequestNotificationsToCompany({ required String companyId}) async {
  await FirebaseFirestore.instance.collection("notifications").doc(companyId).set({
    'notification': FieldValue.arrayUnion(
      ['accept'],
    ),
  }, SetOptions(merge: true));
}
addRejectRequestNotifications({ required String studentId}) async {
  await FirebaseFirestore.instance.collection("notifications").doc(studentId).set({
    'notification': FieldValue.arrayUnion(
      ['reject'],
    ),
  }, SetOptions(merge: true));
}
addRejectRequestNotificationsToCompany({ required String companyId}) async {
  await FirebaseFirestore.instance.collection("notifications").doc(companyId).set({
    'notification': FieldValue.arrayUnion(
      ['reject'],
    ),
  }, SetOptions(merge: true));
}
Future<List<String>> getAdminNotification() async {
  List<String> list = [];

  await FirebaseFirestore.instance
      .collection("adminNotification")
      .get()
      .then((value) {
    for (var i in value.docs) {
     list.add(i['title'].toString());
    }
  });
  return list;
}
