import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/model/company_request.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/student_controller.dart';
import '../../model/company.dart';
import '../../style/app_colors.dart';
import 'home_student.dart';
import 'notifications_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  TextEditingController searchController = TextEditingController();

  List<CompanyRequest> companiesList = [];

  searchCompany(String searchTerm) {
    print(searchTerm);
    FirebaseFirestore.instance
        .collection("companyRequests")
        .where("name", isEqualTo: searchTerm)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        companiesList.add(CompanyRequest.fromJson(result.data(), result.id));
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey2,
      drawer: DrawerWidget(),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        _scaffoldKey2.currentState?.openDrawer();
                      },
                      child: Image.asset(
                        'assets/profile_pic.png',
                        height: 30,
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'search',
                            hintStyle: TextStyle(fontSize: 12),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            prefixIcon: InkWell(
                                onTap: () {
                                  searchCompany(searchController.text);
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 20,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: companiesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ResultJobWidget(
                  companyRequest: companiesList![index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResultJobWidget extends StatelessWidget {
  CompanyRequest companyRequest;

  ResultJobWidget({Key? key, required this.companyRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
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
      child: Row(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(companyRequest.image),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                companyRequest.name,
                style: TextStyle(fontSize: 13),
              ),
              Text(
                'Postion:${companyRequest.address}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Spacer(),
          Column(
            children: [
              SizedBox(
                height: 30,
                child: CustomButton(
                  title: "Apply",
                  background: Colors.white,
                  borderColor: lightPink,
                  textColor: lightPink,
                  onclick: (){
                    _launchUrl(companyRequest.link);

                  },

                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 30,
                child: CustomButton(
                  onclick: (){
                    saveJob(companyId:companyRequest.docId, context: context );
                  },
                  title: "Save",
                  background: Colors.white,
                  borderColor: lightPink,
                  textColor: lightPink,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch url');
    }}
}
