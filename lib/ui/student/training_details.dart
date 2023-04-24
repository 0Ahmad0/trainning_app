import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:training_app/controllers/student_controller.dart';
import 'package:training_app/model/comment.dart';
import 'package:training_app/model/company_request.dart';

import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrainingDetails extends StatefulWidget {
   TrainingDetails({Key? key,required this.company}) : super(key: key);
CompanyRequest company;

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
TextEditingController controller =TextEditingController();
String name='';
List<CommentModel> list=[];
 @override
  void initState() {
   name=SharedPreferencesHelper.sharedPreferences!.getString('name')!;
   getComments(id: widget.company.docId).then((value){
     setState(() {
       list =value;
     });
   });
   setState(() {

   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children:  [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 10,
                        color: Colors.white,
                      ),
                      Text(
                        AppLocalizations.of(context)!.home,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffE1BDF1),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.company.image),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.company.name),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(widget.company.address)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Text(AppLocalizations.of(context)!.comments),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: RatingBarIndicator(
                rating: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return CommentWidget(commentModel:list[index]);
              },
            ),

             SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                             Text(AppLocalizations.of(context)!.writeComments),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                              child: TextFormField(
                                controller: controller,
                                maxLines: 5,
                                decoration:  InputDecoration(
                                  filled: true,
                                  labelText: AppLocalizations.of(context)!.writeHere,
                                  fillColor: lightGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      right: 110,
                      left: 110,
                      child: SizedBox(
                        height: 25,
                        child: CustomButton(
                          title: AppLocalizations.of(context)!.send,
                          background: darkPink,
                          borderColor: darkPink,
                          textColor: Colors.white,
                          onclick: () {
                            if(controller.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("حقل التعليق مطلوب")));
                            }else{
                              sendComment(comment: controller.text, id: widget.company.docId, name: name, context: context);

                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
   CommentWidget({
    Key? key,
     required this.commentModel
  }) : super(key: key);
CommentModel commentModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      padding: const EdgeInsets.only(
          top: 20, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.black),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(
            commentModel.name,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            commentModel.comment,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
