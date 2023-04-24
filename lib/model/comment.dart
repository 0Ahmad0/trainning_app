class CommentModel{
  var name;
  var comment;
  var id;

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    comment = json['comment'];
    id = json['id'];
  }
}