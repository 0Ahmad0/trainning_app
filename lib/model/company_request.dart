class CompanyRequest{
   var link;
   var address;
   var name;
   var image;
   var status;
   var docId;
   var id;
   var number;

   //LatLng location,
   CompanyRequest();
   CompanyRequest.fromJson(Map<String, dynamic> json,var documentId) {

     link = json['link'];
     address = json['address'];
     name = json['name'];
     image = json['image'];
     status =json['status'];
     id =json['id'];
     docId= documentId;
     number =json['number'];

   }
}