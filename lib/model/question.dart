class Question{
  var englishQuestion;
  var arabicQuestion;
  var englishAnswer;
  var arabicAnswer;

  Question.fromJson(Map<String, dynamic> json) {
    englishQuestion = json['Eqestion'];
    englishAnswer = json['Eanswer'];
    arabicAnswer = json['answer'];
    arabicQuestion = json['question'];

  }
}