import 'package:flutter/material.dart';
import 'package:project1/result.dart';
import 'quiz.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();
  final TextEditingController _controllerS = TextEditingController();
  bool _loading = false;


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerId.dispose();
    _controllerS.dispose();
    super.dispose();
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
              Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      SizedBox(width: 200,
                          child:TextFormField(
                            validator: (value) => (value == null || value.isEmpty)?'Please fill ID': null,
                            controller: _controllerId,
                            decoration: const InputDecoration(
                                hintText: 'Enter ID',
                                border: OutlineInputBorder()
                            ),
                          )),
                      const SizedBox(height: 10),
                      SizedBox(width: 200,
                          child:TextFormField(
                            validator: (value) => (value == null || value.isEmpty)?'Please fill name': null,
                            controller: _controllerName,
                            decoration: const InputDecoration(
                                hintText: 'Enter name',
                                border: OutlineInputBorder()
                            ),
                          )),
                      const SizedBox(height: 10),
                      SizedBox(width: 200,
                          child:TextFormField(
                            validator: (value) => (value == null || value.isEmpty)?'Please fill section': null,
                            controller: _controllerS,
                            decoration: const InputDecoration(
                                hintText: 'Enter Section',
                                border: OutlineInputBorder()
                            ),
                          )),
                      const SizedBox(height: 16.0,),
                      ElevatedButton(onPressed:_loading? null : (){
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Quiz(
                                  id: int.parse(_controllerId.text),
                                  name: _controllerName.text,
                                  section: _controllerS.text,
                                ),
                              ),
                            );
                          });
                        }
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('START', style: TextStyle(fontSize: 24.0),
                          )
                      ),
                      const SizedBox(height: 16.0,),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Result(),
                            )
                        );
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('GRADES', style: TextStyle(fontSize: 20.0),
                          )
                      ),
                      const SizedBox(height: 16.0,),
                      Visibility(visible: _loading ,child: const CircularProgressIndicator())
                    ],
                  )
                ))
            ],
          ),),
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

