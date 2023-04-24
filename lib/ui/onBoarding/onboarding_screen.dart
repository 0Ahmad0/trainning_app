import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:training_app/style/app_colors.dart';
import 'package:training_app/ui/auth/login_screen.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../main.dart';
import '../auth/new_account/signup_screen.dart';
import '../training_organization/new_account.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

String lang ='العربية';

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boardingBages = [
      BoardingModel(
          id: 2,
          image: "assets/boarding1.png",
          title: '',
          body:  AppLocalizations.of(context)!.track),
      BoardingModel(
        id: 1,
        image: "assets/boarding2.png",
        title: AppLocalizations.of(context)!.system,
        body: AppLocalizations.of(context)!.use,
      ),
    ];
    var languageModel = Provider.of<LanguageModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                 InkWell(
                  onTap: () async {
                    if( Provider.of<LanguageModel>(context, listen: false).locale==const Locale('ar')
                    ){
                      Provider.of<LanguageModel>(context, listen: false)
                          .changeLanguage(Locale('en'));
                      lang="English";
                    }else{
                      Provider.of<LanguageModel>(context, listen: false)
                          .changeLanguage(Locale('ar'));
                      lang="العربية";
                    }


    //   Locale newLanguage = languageModel.selectedLanguage == Locale("ar") ? Locale("en") : Locale("ar");
    //   languageModel.changeLanguage(newLanguage);
    //   if(lang=="العربية"){
    //     setState(() {
    //       lang='English';
    //     });
    //   }else{
    //     setState(() {
    //       lang='العربية';
    //     });
    //   }
    //
    // },
    },
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(lang),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  child: Image.asset('assets/entern_logo.png'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: PageView.builder(
                onPageChanged: (v) {},
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildBoardingItem(boardingBages[index]);
                },
                itemCount: boardingBages.length,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: boardingBages.length,
                    effect: const ScrollingDotsEffect(
                      dotColor: Color(0xffE9ADDE),
                      spacing: 5.0,
                      dotWidth: 8,
                      dotHeight: 8.0,
                      activeDotColor: Color(0xffE9ADDE),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 5,
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
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          title: AppLocalizations.of(context)!.register,
                          textColor: lightPurple,
                          background: lightGrey,
                          borderColor: lightGrey,
                          //go to sign uo screen
                          onclick: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                             Text(
                                              AppLocalizations.of(context)!.membershipType,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const Divider(
                                              color: darkPink,
                                              thickness: 1,
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            MemberNameWidget(
                                              title: AppLocalizations.of(context)!.student,
                                              nextScreen: SignUpScreen(),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            MemberNameWidget(
                                              title:AppLocalizations.of(context)!.company,
                                              nextScreen:
                                                  NewOrganizationAccount(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },);

                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          title:  AppLocalizations.of(context)!.login,
                          textColor: lightPurple,
                          background: lightGrey,
                          borderColor: lightGrey,
                          onclick: () {
                            //go to login screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xffC47CE4),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffC47CE4),
              fontSize: 15,
            ),
          ),
        ],
      );
}

class BoardingModel {
  final int id;
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.id,
    required this.image,
    required this.title,
    required this.body,
  });
}

class MemberNameWidget extends StatefulWidget {
  final String title;
  final Widget nextScreen;

  MemberNameWidget({Key? key, required this.title, required this.nextScreen})
      : super(key: key);

  @override
  _MemberNameWidgetState createState() => _MemberNameWidgetState();
}

class _MemberNameWidgetState extends State<MemberNameWidget> {
  Color color = Colors.white;
  Color colorText = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        color = darkPink;
        colorText = Colors.white;
        setState(() {});
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget.nextScreen));
      },
      child: Container(
        height: 35,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
