import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/model/company_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/admin_controller.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyRequestPage extends StatefulWidget {
  CompanyRequest companyRequest;

  CompanyRequestPage({Key? key, required this.companyRequest})
      : super(key: key);

  @override
  State<CompanyRequestPage> createState() => _CompanyRequestPageState();
}

class _CompanyRequestPageState extends State<CompanyRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 120,
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Row(
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.companyRequest.image),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.companyRequest.name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
         /*   Container(
              height: 100,
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(widget.companyRequest.in),
                  Spacer(),
                  // Icon(Icons.add),
                ],
              ),
            ),*/
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Text(
                widget.companyRequest.address,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Text(
                widget.companyRequest.link,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                  width: 100,
                  child: CustomButton(
                    textSize: 12,
                    title: AppLocalizations.of(context)!.approve,
                    background: Colors.white,
                    borderColor: darkPink,
                    textColor: darkPink,
                    onclick: () {
                      acceptCompanyRequest(widget.companyRequest.docId, context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: CustomButton(
                    textSize: 12,
                    title: AppLocalizations.of(context)!.reject,
                    background: Colors.white,
                    borderColor: darkPink,
                    textColor: darkPink,
                    onclick: () {
                      rejectCompanyRequest(
                          widget.companyRequest.docId, context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
