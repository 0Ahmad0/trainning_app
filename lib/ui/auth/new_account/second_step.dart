import 'package:flutter/material.dart';
import 'package:training_app/model/student.dart';
import 'package:training_app/ui/auth/new_account/phone_number_step.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SecondStep extends StatefulWidget {
  SecondStep({Key? key, required this.newStudent}) : super(key: key);
  final Student newStudent;

  @override
  State<SecondStep> createState() => _SecondStepState();
}

class _SecondStepState extends State<SecondStep> {
  String interestValue = 'Information Technology';
  String state = '0';

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Container(
                      width: 120,
                      height: 50,
                      padding: EdgeInsets.only(right: 50),
                      child: Image.asset('assets/entern_logo.png')),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20, top: 15, left: 20),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.name),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 12),
                          hintText: AppLocalizations.of(context)!.name),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.jobInterest,
                          style: TextStyle(color: textColor),
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                  value: AppLocalizations.of(context)!
                                      .informationTechnology,
                                  groupValue: interestValue,
                                  onChanged: (v) {
                                    setState(() {
                                      interestValue = v.toString();
                                      state = '0';
                                    });
                                  }),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .informationTechnology,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                value:AppLocalizations.of(context)!.accountingAndFinance,
                                groupValue: interestValue,
                                onChanged: (v) {
                                  setState(() {
                                    interestValue = v.toString();
                                    state = '1';
                                  });
                                },
                              ),
                            ),
                             Text(
                              AppLocalizations.of(context)!.accountingAndFinance,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                value: AppLocalizations.of(context)!.healthCare,
                                groupValue: interestValue,
                                onChanged: (v) {
                                  setState(() {
                                    interestValue = v.toString();
                                    state = '2';
                                  });
                                },
                              ),
                            ),
                             Text(
                              AppLocalizations.of(context)!.healthCare,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                value: AppLocalizations.of(context)!
                                    .engineeringAndManufacturing,
                                groupValue: interestValue,
                                onChanged: (v) {
                                  setState(() {
                                    interestValue = v.toString();
                                    state = '3';
                                  });
                                },
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .engineeringAndManufacturing,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                  value: AppLocalizations.of(context)!.media,
                                  groupValue: interestValue,
                                  onChanged: (v) {
                                    setState(() {
                                      interestValue = v.toString();
                                      state = '4';
                                    });
                                  }),
                            ),
                            Text(
                              AppLocalizations.of(context)!.media,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                  value: AppLocalizations.of(context)!
                                      .scienceAndPharmaceuticals,
                                  groupValue: interestValue,
                                  onChanged: (v) {
                                    setState(() {
                                      interestValue = v.toString();
                                      state = '5';
                                    });
                                  }),
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .scienceAndPharmaceuticals,
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Spacer(),
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 15),
                    width: 120,
                    height: 30,
                    child: CustomButton(
                      borderColor: lightPink,
                      background: Colors.white,
                      title: AppLocalizations.of(context)!.next,
                      textColor: lightPink,
                      onclick: () {
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(' يرجى ادخال الاسم '),
                            ),
                          );
                        } else {
                          widget.newStudent.interest = interestValue.toString();
                          widget.newStudent.name = nameController.text;
                          widget.newStudent.state = state.toString();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PhoneNumberStep(
                                newStudent: widget.newStudent,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
