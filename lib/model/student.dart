class Student {
  String? email;
  String? password;
  var name;
  var interest;
  var state;
  String? phone;
  String? isSendRequest;
  var level;
  var language;
  var other;
  var skill;
  var dob;
  var city;
  var nationality;
 var gender;
 var exp;
 var img;
  Student({this.name, this.email, this.interest, this.phone, this.password,this.img});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    interest = json['interest'];
    state = json['state'];
    isSendRequest = json['isSendRequest'];
    level = json['level'];
    language = json['language'];
    other = json['other'];
    skill = json['skill'];
    dob = json['dob'];
    city = json['city'];
    nationality = json['nationality'];
    gender =json['gender'];
    exp=json['exp'];
    img =json['img']==''?null:json['img'];
  }
}

