

class CategoryQue {
  var name;
  var id;
  var Name;


  CategoryQue({ this.name, this.id, this.Name});

  CategoryQue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    Name = json['Name'];

  }
}

class QuestionCate {
  var Answer;
  var answer;
  var Que;
  var que;
  var id;


  QuestionCate({this.Answer, this.id, this.answer,this.Que,this.que});

  QuestionCate.fromJson(Map<String, dynamic> json) {
    Answer = json['Answer'];
    id = json['id'];
    answer = json['answer'];
    Que = json['Que'];
    que = json['que'];

  }
}


class Converstaion{
 String  Question;
 String Answer;
 Converstaion({required this.Question,required this.Answer});
}
