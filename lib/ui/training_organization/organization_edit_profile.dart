import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:training_app/controllers/company_controller.dart';
import '../../controllers/shared_preference_controller.dart';
import '../../style/app_colors.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrganizationEditProfile extends StatefulWidget {
  OrganizationEditProfile({Key? key}) : super(key: key);

  @override
  State<OrganizationEditProfile> createState() =>
      _OrganizationEditProfileState();
}

class _OrganizationEditProfileState extends State<OrganizationEditProfile> {
  TextEditingController infoController = TextEditingController();
  bool isImageSelected = false;
  File? file;
  String name = '';
  String info = '';
  bool isLoading = false;

  @override
  void initState() {
    name = SharedPreferencesHelper.sharedPreferences!.getString('name') ?? '';
    info = SharedPreferencesHelper.sharedPreferences!.getString('info') ?? "";
    /*  image = SharedPreferencesHelper.sharedPreferences!
        .getString('image') ?? "";*/
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
                        AppLocalizations.of(context)!.editProfile,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    // Icon(Icons.edit),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading == false
                ? const SizedBox()
                : const LinearProgressIndicator(
                    backgroundColor: lightPurple,
                    color: darkPurple,
                  ),
            /*InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MapScreen(),
                  ),
                );
              },
              child: Container(
                child: Text('select locarion'),
                decoration: const BoxDecoration(
                  color: lightGrey,
                ),
              ),
            ),*/
            Container(
              height: 120,
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 10),
              decoration: const BoxDecoration(
                color: lightGrey,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      pickCompanyPhoto(context).then((value) {
                        if (value != null) {
                          file = value;
                          setState(() {
                            isImageSelected = true;
                          });
                        }
                      });
                    },
                    child: isImageSelected == false
                        ? const SizedBox(
                            height: 90,
                            width: 90,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 90,
                            width: 90,
                            child: CircleAvatar(
                              backgroundImage: FileImage(file!),
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 180,
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                decoration: const BoxDecoration(
                  color: lightGrey,
                ),
                child: TextFormField(
                  controller: infoController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    hintText:
                        AppLocalizations.of(context)!.enterCompanyInformation,
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  maxLines: 5,
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              child: CustomButton(
                title: AppLocalizations.of(context)!.save,
                background: Colors.white,
                borderColor: lightPink,
                textColor: lightPink,
                onclick: () {
                  setState(() {
                    isLoading = true;
                  });
                  updateProfile(
                    context: context,
                    name: name,
                    image: file,
                    info: infoController.text.isEmpty
                        ? info
                        : infoController.text,
                  ).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                  });
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
    print("save notification");
    if (_selectedLocation == null) return;
    //FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await FirebaseFirestore.instance.collection("locations").add({
      "latitude": _selectedLocation?.latitude ?? '',
      "longitude": _selectedLocation?.longitude ?? "",
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveLocation,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
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
