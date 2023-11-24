import 'package:flutter/material.dart';
import 'quiz.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerS = TextEditingController();


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerId.dispose();
    _controllerS.dispose();
    super.dispose();
  }

  void openQuiz() {
    try {
      String name = _controllerName.text.trim();
      String idText = _controllerId.text;
      String section = _controllerS.text;

      if (name.isEmpty || idText.isEmpty || section.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all the fields')),
        );
        return;
      }

      int id;
      try {
        id = int.parse(idText);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ID must be a valid number')),
        );
        return;
      }

      List<String> nameParts = name.split(' ');

      if (nameParts.length >= 2 && _isAlpha(nameParts[0]) && _isAlpha(nameParts[1])) {
        if (_isAlpha(section)) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Quiz()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Section must contain only alphabetic characters')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a full name with at least two parts')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check if all your information are correct')),
      );
    }
  }



  bool _isAlpha(String input) {
    RegExp alphaPattern = RegExp(r'^[a-zA-Z]+$');
    return alphaPattern.hasMatch(input);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('A+'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body:SingleChildScrollView(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10.0,),
              const EditText(text:' Welcome Dear!'),
              const SizedBox(height: 24.0,),
              const EditText(text: 'Before Starting The Quiz You Should Know The Following Information:'),
              const SizedBox(height: 16.0,),
              const EditText(text: '1) Add Your Full Name'),
              const SizedBox(height: 16.0,),
              const EditText(text: '2) Add Your ID'),
              const SizedBox(height: 16.0,),
              const EditText(text: '3) Add Your Section'),
              const SizedBox(height: 16.0,),
              const EditText(text: 'PRESS ON THE BELOW BUTTON TO START THE QUIZ'),
              const SizedBox(height: 16.0,),
              const EditText(text: 'GOOD LUCK ON YOUR QUIZ!'),
              const SizedBox(height: 30.0,),
              const EditText(text: 'Enter your name:'),
              const SizedBox(height: 16.0,),
              SizedBox(width: 300.0, height: 50.0,
                      child: TextField(controller: _controllerName,keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 18.0),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Enter Your Name'
                        ),
                      ),
                    ),
              const SizedBox(height: 30.0,),
              const EditText(text: 'Enter your ID:'),
              const SizedBox(height: 16.0,),
              SizedBox(width: 300.0, height: 50.0,
                child: TextField(controller: _controllerId,keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Your ID'
                  ),
                ),
              ),

              const SizedBox(height: 30.0,),
              const EditText(text: 'Enter your Section:'),
              const SizedBox(height: 16.0,),
              SizedBox(width: 300.0, height: 50.0,
                child: TextField(controller: _controllerS,keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18.0),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Your Section'
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              ElevatedButton(onPressed:openQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('START', style: TextStyle(fontSize: 24.0),
                  )
              ),
              const SizedBox(height: 16.0,)
            ],
           )
          )
      );
  }
}

class EditText extends StatelessWidget {
  final String text;
  const EditText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: const TextStyle(
              fontSize: 24,
              color: Colors.black
          )
      ),
    );
  }
}
