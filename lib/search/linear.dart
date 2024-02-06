import 'dart:math';
import 'package:flutter/material.dart';

class LinearPage extends StatefulWidget {
  @override
  _LinearPageState createState() => _LinearPageState();
}

class _LinearPageState extends State<LinearPage> {
  List<int> numbers = List.generate(10, (index) => index + 60 - 10);
  TextEditingController _searchController = TextEditingController();
  int? target;
  int? foundIndex;
  double speed = 1.0; // Default speed
  bool notFound = false;

  void shuffleNumbers() {
    setState(() {
      numbers.shuffle();
      target = null;
      foundIndex = null;
      notFound = false;
    });
  }

  void generateNumbers() {
    setState(() {
      Random random = Random();
      numbers = List.generate(10, (index) => random.nextInt(100) + 1);
      foundIndex = null;
      notFound = false;
    });
  }

  Future<void> linearSearch() async {
    // Check if a valid number is entered
    if (_searchController.text.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(_searchController.text)) {
      // Show an error prompt
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid number.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    for (int i = 0; i < numbers.length; i++) {
      setState(() {
        target = int.tryParse(_searchController.text);
        foundIndex = i;
      });

      // Simulating delay for visualization based on the speed
      await Future.delayed(Duration(milliseconds: (500 ~/ speed).round()));

      if (numbers[i] == target) {
        setState(() {
          foundIndex = i;
          notFound = false;
        });
        return;
      }
    }

    // Number not found
    setState(() {
      notFound = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linear Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  for (int i = 0; i < numbers.length; i++)
                    Expanded(
                      child: Container(
                        width: 50, // Fixed size for the circles
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          color: foundIndex != null && i == foundIndex
                              ? Colors.green
                              : i == target
                              ? Colors.blue
                              : Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            numbers[i].toString(),
                            style: TextStyle(
                              color: i == target ? Colors.white : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    shuffleNumbers();
                  },
                  child: Text('Shuffle Numbers'),
                ),
                ElevatedButton(
                  onPressed: () {
                    generateNumbers();
                  },
                  child: Text('Generate'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Speed:'),
                Slider(
                  value: speed,
                  min: 0.1,
                  max: 2.0,
                  onChanged: (value) {
                    setState(() {
                      speed = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter a number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await linearSearch();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            notFound
                ? Text(
              'Number not found',
              style: TextStyle(fontSize: 16, color: Colors.red),
            )
                : foundIndex != null
                ? Text(
              'Number found at index $foundIndex',
              style: TextStyle(fontSize: 16, color: Colors.green),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
