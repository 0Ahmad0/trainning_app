class StudentRequest{
  var name;
  var status;
  var major;
  var file;
  var id;
  StudentRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    major =json['interest'];
    file = json['file'];
    id=json['id'];

  }
}