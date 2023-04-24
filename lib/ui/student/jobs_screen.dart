import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:training_app/controllers/student_controller.dart';
import '../../model/company_request.dart';
import '../../style/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JobScreen extends StatefulWidget {
  JobScreen({Key? key}) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CompanyRequest> companiesList = [];
  List<CompanyRequest> appliedList = [];

  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getSaved().then((value) {
      companiesList = value;
      setState(() {});
    });
    getAppliedCompany().then((value){
      appliedList=value;
      setState(() {});
    });
    setState(() {});
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 77,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.jobs,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      indicatorColor: lightPurple,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.applied,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.saved,
                        )
                      ],
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
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: appliedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SavedJobWidget(
                      companyRequest: appliedList[index],
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: companiesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SavedJobWidget(
                      companyRequest: companiesList[index],
                    );
                  },
                ),


                // second tab bar view widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppliedJobWidget extends StatelessWidget {
  const AppliedJobWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            //color of shadow
            spreadRadius: 2,
            //spread radius
            blurRadius: 5,
            // blur radius
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Company :Aramco'),
              Text('Postioin:IT Assistance'),
              Text('Region:Eastren'),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Spacer(), Text('Status:Pending')],
          )
        ],
      ),
    );
  }
}

class SavedJobWidget extends StatelessWidget {
  CompanyRequest companyRequest;

  SavedJobWidget({Key? key, required this.companyRequest}) : super(key: key);

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
        ],
      ),
    );
  }
}
