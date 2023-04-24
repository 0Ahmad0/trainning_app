import 'package:flutter/material.dart';
import 'package:training_app/ui/widgets/custom_button.dart';

import '../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Contact Info',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.phone,
                                color: darkPurple,
                                size: 20,
                              ),
                              Text(
                                '+966511111111',
                                style:
                                    TextStyle(fontSize: 15, color: darkPurple),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.email,
                                color: darkPurple,
                                size: 20,
                              ),
                              Text(
                                'entern@gmail.com',
                                style:
                                    TextStyle(fontSize: 15, color: darkPurple),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: darkPurple,
                                size: 20,
                              ),
                              Text(
                                'Eastern, dammam, Kingdom of Saudi Arabia',
                                style:
                                    TextStyle(fontSize: 15, color: darkPurple),
                              ),
                            ],
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
                        title: "Contact Us",
                        background: Colors.white,
                        borderColor: lightPink,
                        textColor: lightPink,
                        onclick: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
