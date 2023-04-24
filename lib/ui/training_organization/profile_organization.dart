import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:training_app/ui/training_organization/organization_edit_profile.dart';
import 'package:training_app/ui/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controllers/company_controller.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';

class ProfileOrganization extends StatefulWidget {
  const ProfileOrganization({Key? key}) : super(key: key);

  @override
  State<ProfileOrganization> createState() => _ProfileOrganizationState();
}

class _ProfileOrganizationState extends State<ProfileOrganization> {
  String name = '';
  String info = '';
  String image = '';
  LatLng? _selectedLocation;
  String? selectedLocationString;
  bool isLoading = false;
  TextEditingController linkController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    name = SharedPreferencesHelper.sharedPreferences!.getString('name') ?? '';
    info = SharedPreferencesHelper.sharedPreferences!.getString('info') ?? "";
    image = SharedPreferencesHelper.sharedPreferences!.getString('image') ?? "";
    print(image);
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
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => OrganizationEditProfile(),
                            ),
                          )
                              .then((value) {
                            print(value);
                            print('in then');
                          });
                        },
                        child: Icon(Icons.edit)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading == true
                ? const LinearProgressIndicator(
                    color: darkPurple,
                    backgroundColor: lightPurple,
                  )
                : SizedBox(),
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
                  image == ''
                      ? const SizedBox(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(image),
                          )),
                  const SizedBox(
                    width: 20,
                  ),
                 // Text(AppLocalizations.of(context)!.number),

                  SizedBox(height: 10,),
                  Text(
                    name,
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
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: TextFormField(
                controller:numberController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.number,
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
           SizedBox(height: 10,),
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
                  Text(info),
                  Spacer(),
                  // Icon(Icons.add),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.address,
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => MapScreen(),
                  ),
                )
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _selectedLocation = value;
                      _selectedLocation!.latitude;
                      selectedLocationString =
                          "${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}";
                    });
                  }
                });
              },
              child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: const BoxDecoration(
                  color: lightGrey,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _selectedLocation != null
                        ? Text(
                            selectedLocationString!,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context)!.locationInMap,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 13),
                          ),
                    Spacer(),
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: TextFormField(
                controller: linkController,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.linkToApply,
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),

              child: CustomButton(
                title:
                AppLocalizations.of(context)!.sendRequest,
                background: Colors.white,
                borderColor: lightPink,
                textColor: lightPink,
                onclick: () async {
                  if (addressController.text.isEmpty |
                      linkController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('يرجى ادخال جميع الحقول')));
                  } else if (_selectedLocation == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يرجى اختيار موقع')));
                  } else if (image == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('يرجى اختيار صورة')));
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    await sendCompanyRequest(
                      name: name,
                      context: context,
                      image: image,
                      address: addressController.text,
                      link: linkController.text,
                      number:numberController.text,
                      location: _selectedLocation!,

                    ).then((value) async {

                      setState(() {
                        isLoading = false;
                      });
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng? _selectedLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
  }

  void _saveLocation() async {
    if (_selectedLocation == null) return;
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveLocation,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.4219999, -122.0840575),
          zoom: 16.0,
        ),
        onTap: _selectLocation,
        markers: Set.of(
          _selectedLocation == null
              ? []
              : [
                  Marker(
                    markerId: MarkerId("selected"),
                    position: _selectedLocation!,
                  ),
                ],
        ),
      ),
    );
  }
}
