import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/model/company_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/student_controller.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyOffer extends StatefulWidget {
  String companyRequest;
   CompanyOffer({Key? key,required this.companyRequest}) : super(key: key);

  @override
  State<CompanyOffer> createState() => _CompanyOfferState();
}



class _CompanyOfferState extends State<CompanyOffer> {
 CompanyRequest offer=CompanyRequest();
  @override
  void initState() {
    getCompanyOffer(company: widget.companyRequest).then((value) {
      offer=value!;
      setState(() {

      });
    });
    setState(() {

    });
    super.initState();
  }
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        AppLocalizations.of(context)!.profile,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 5,
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
                        backgroundImage: NetworkImage(offer?.image??""),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                   Text(
                    offer!.name,
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
            Container(
              height: 100,
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offer!.address),
                  Spacer(),
                  // Icon(Icons.add),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),


            const SizedBox(
              height: 10,
            ),

            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomButton(
                title:
                AppLocalizations.of(context)!.apply,
                background: Colors.white,
                borderColor: lightPink,
                textColor: lightPink,
                onclick: () async {
                  _launchUrl(offer!.link);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch url');
  }
}
}
