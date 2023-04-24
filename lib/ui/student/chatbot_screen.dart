import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/style/app_colors.dart';
import '../../controllers/student_controller.dart';
import '../../main.dart';
import '../../model/Faq.dart';
import '../../model/question.dart';
import '../contact_info.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  List<Question> questionList = [];
  List<CategoryQue> categoryQue = [];
  List<QuestionCate> question = [];
  int massage = 0;
  List<Converstaion> conversation = [];

  int lang = 1;

  checkLanguage() {
    if (Provider.of<LanguageModel>(context, listen: false).locale ==
        const Locale('ar')) {
      lang = 1; //Arabic
      setState(() {});
    } else {
      lang = 2;
      setState(() {});
    }
  }

  @override
  void initState() {
    getChatBootQuestion().then((value) {
      questionList = value;
      setState(() {});
    });
    getCategoryQuestion().then((value) {
      categoryQue = value;
      setState(() {});
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
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
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Icon(
                          Icons.keyboard_backspace_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'virtual assistant',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Provider.of<LanguageModel>(context, listen: false).locale ==
                              const Locale('ar')?
                          Text(
                              "السلام عليكم، أنا مساعدك الافتراضي من تطبيق انترن!👋🏼 \n"
                              " كيف يمكنني أن اساعدك؟\n"):
                          Text(
                              "Peace be upon you, I am your virtual assistant from the Intern app!👋🏼\n"
                              " how can I help you?\n"),

                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: categoryQue.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    onPressed: ()  async{
                                    await   getQuestion(
                                              id: categoryQue[index].id.toString())
                                          .then((value) {
                                            setState(() {
                                          question = value;
                                        });

                                      });
                                      showlist(context);
                                    },
                                    child:
                                    Provider.of<LanguageModel>(context, listen: false).locale ==
                                        const Locale('ar')?
                                        Text(" - ${categoryQue[index].name}"):
                                        Text(" - ${categoryQue[index].Name}")

                                );
                              },
                            ),
                          ),
                          TextButton(
                              onPressed: ()  {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ContactInfo(),
                                  ),
                                );
                              },
                              child: Provider.of<LanguageModel>(
                                  context,
                                  listen: false)
                                  .locale ==
                                  const Locale('ar')
                                  ? Text(
                                  " - أخرى ")
                                  : Text(
                                  " - other")),
                        ],
                      ))),
              ListView.builder(
                shrinkWrap: true,
                itemCount: massage,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return massageWidget(answer: conversation[index].Answer,Que: conversation[index].Question);
                },
              ),
            ]),
      ),
    );
  }

  showlist(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: question.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(
                        Provider.of<LanguageModel>(context, listen: false).locale ==
                            const Locale('ar')?
                        question[index].que:
                        question[index].Que, textDirection:
                    Provider.of<LanguageModel>(context, listen: false).locale ==
                        const Locale('ar')?
                    TextDirection.rtl:
                    TextDirection.ltr),
                onTap: () {
                  setState(() {
                    Provider.of<LanguageModel>(context, listen: false).locale ==
                        const Locale('ar')?
                    conversation.add(
                        Converstaion(Question: question[index].que, Answer: question[index].answer)
                    ):
                    conversation.add(
                      Converstaion(Question: question[index].Que, Answer: question[index].Answer)
                    );
                    massage++;
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget massageWidget({required String Que,required String answer}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 10),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(

                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            lightYallow,
                            lightPink,
                            lightPurple,
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(Que))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(answer))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
