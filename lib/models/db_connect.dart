import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse('https://jsosdao.firebaseio.com/questions.json');

  Future<List<Question>> fetchQuestions() async {
    // http 요청을 보내고 응답을 기다림
    var response = await http.get(url);

    // 응답 본문을 JSON으로 디코딩
    var data = json.decode(response.body) as Map<String, dynamic>;

    // Question 객체들을 담을 리스트 생성
    List<Question> newQuestions = [];

    // 각 데이터를 Question 객체로 변환
    data.forEach((key, value) {
      var newQuestion = Question(
        id: key,
        title: value['title'],
        options: Map.castFrom(value['options']),
      );
      newQuestions.add(newQuestion);
    });

    // Question 객체 리스트 반환
    return newQuestions;
  }
}
