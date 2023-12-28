import 'package:flutter/material.dart';
import 'Q&A.dart';

class   Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _HomeState();
}

class _HomeState extends State<Result> {
  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateStudents(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false; // show progress bar
              updateStudents(update); // update data asynchronously
            });
          }, icon: const Icon(Icons.refresh)),
        ],
          title: const Text('Grades'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        // load products or progress bar
        body: _load ? const ShowStudents() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}