import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> questionsList = [
    "ما هو اللون الذي يتكون من مزج الأحمر والأصفر؟",
    "ما هو الحيوان الذي يعتبر أسرع حيوان في العالم؟",
    "ما هي لغة البرمجة التي تستخدم في تطوير تطبيقات الويب من جانب الخادم؟",
    "ما هو اللون الذي يرمز إلى الحزن؟",
    "أي حيوان يُعرف بأنه ملك الغابة؟",
    "ما هي لغة البرمجة الأكثر شيوعًا لتطوير تطبيقات الهواتف الذكية؟",
  ];

  final List<List<String>> answersList = [
    ["برتقالي", "أخضر", "بنفسجي"],
    ["الفهد", "الحصان", "الغراب"],
    ["بايثون", "جافا", "سي شارب"],
    ["أسود", "أبيض", "أحمر"],
    ["الأسد", "النمر", "الدب"],
    ["جافا", "بايثون", "روبي"],
  ];

  List<int?> selectedAnswers = [];
  int _questionIndex = 0;

  void answerQuestion(int answerIndex) {
    setState(() {
      selectedAnswers.add(answerIndex);
      if (_questionIndex < questionsList.length - 1) {
        _questionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              questions: questionsList,
              answers: answersList,
              selectedAnswers: selectedAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quiz App"),
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.lightGreen[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questionsList[_questionIndex],
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            ...List.generate(answersList[_questionIndex].length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(
                    answersList[_questionIndex][index],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final List<String> questions;
  final List<List<String>> answers;
  final List<int?> selectedAnswers;

  ResultsScreen({
    required this.questions,
    required this.answers,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("result test"),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(questions[index]),
            subtitle: Text(
              "answers: ${selectedAnswers[index] != null ? answers[index][selectedAnswers[index]!].toString() : 'لم يتم الاختيار'}",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
