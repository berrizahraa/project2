import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'Q&A.dart';
import 'home.dart';

const String baseURL ='zahraaberri.000webhostapp.com';


class Quiz extends StatefulWidget {
  final int id;
  final String name;
  final String section;

  const Quiz({required this.id, required this.name, required this.section, super.key});


  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //define the data
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  bool _isQuizSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('A+'),
              centerTitle: true,
              backgroundColor: Colors.green,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
                child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center, children: [
                  const SizedBox(height: 24),
                  const Text(
                    "Quiz Started",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _questionWidget(),
                  const SizedBox(height: 24),
                  _answerList(),
                  const SizedBox(height: 24),
                  _nextButton(),
                ]
                )
            )
        )
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length
              .toString()}",
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
      )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: isSelected ? Colors.black38 : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white, //change text color in button
        ),
        onPressed: _isQuizSubmitted // Prevent submission if quiz is already submitted
            ? null
            : () {
          if (isLastQuestion) {
            saveInfo((p0) => null, widget.id, widget.name, widget.section,
                score);

            // Update state to indicate that quiz has been submitted
            setState(() {
              _isQuizSubmitted = true;
            });
          } else {
            // Next question logic
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }


  void saveInfo(Function(String) update, int id, String name, String section,
      int score) async {
    try {
      final url = Uri.https(baseURL, 'insertStudents.php');
      final response = await http.post(url,
          headers: <String, String>{
            'content-type': 'application/json; charset=UTF-8'}, //mime type
          body: convert.jsonEncode(<String, String>{
            'id': '$id',
            'name': name,
            'section': section,
            'score': '$score',
            'key': 'Zahraaberri2!'
          })
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        update(response.body);
      }
    }
    catch (e) {
      update('connection error');
    }
  }

}
