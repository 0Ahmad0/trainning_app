import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  var name;
  var description;
  var location;
  var rating;
  var email;
  var info;
  var image;

  Company({this.name, this.description, this.location, this.rating});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    location = json['location'];
    rating = json['rating'];
    info = json['info'];
    image = json['image'];
  }
}
