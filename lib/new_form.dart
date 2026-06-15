import 'package:flutter/material.dart';

class NewForm extends StatefulWidget {
  const NewForm({super.key});

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Form")),
      body: Column(
        children: [
          Text('Counter: $counter'),
          ElevatedButton(onPressed: increment, child: Text("Tambah")),
        ],
      ),
    );
  }
}
