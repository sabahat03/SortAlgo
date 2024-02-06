import 'dart:math';
import 'package:flutter/material.dart';

class InsertionSortPage extends StatefulWidget {
  @override
  _InsertionSortPageState createState() => _InsertionSortPageState();
}

class _InsertionSortPageState extends State<InsertionSortPage> {
  List<int> array = [];
  double maxBarHeight = 215.0;
  double barWidth = 40.0;
  int speed = 1;
  int sortedIndex = -1;
  int currentIndex = -1;
  String message = '';
  bool showPrompt = true;
  bool isSorting = false;

  @override
  void initState() {
    super.initState();
    generateArray();
  }

  void generateArray() {
    final random = Random();
    Set<int> uniqueValues = Set<int>();

    while (uniqueValues.length < 8) {
      uniqueValues.add(random.nextInt(100) + 1);
    }

    array = uniqueValues.toList();
    sortedIndex = -1;
    currentIndex = -1;
    message = '';

    // Show prompt only if it hasn't been shown before
    if (showPrompt) {
      showPrompt = false;
      Future.delayed(Duration.zero, () => showSortingPrompt());
    }

    setState(() {});
  }

  void showSortingPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Insertion Sort',
            style: TextStyle(color: Colors.blue),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Time Complexity:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Worst Case: O(n^2)\nAverage Case: O(n^2)\nBest Case: O(n)',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                'Definition:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Insertion Sort is a simple sorting algorithm that builds the final sorted array one item at a time. It is much less efficient on large lists than more advanced algorithms but provides advantages for small or mostly sorted datasets.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Text('Let\'s Go'),
            ),
          ],
        );
      },
    );
  }

  void hidePrompt() {
    setState(() {
      showPrompt = false;
    });
  }

  void stopSorting() {
    setState(() {
      isSorting = false;
    });
  }

  Future<void> insertionSort() async {
    int n = array.length;

    hidePrompt(); // Hide prompt when sorting starts
    isSorting = true;

    for (int i = 1; i < n && isSorting; i++) {
      int key = array[i];
      int j = i - 1;

      // Mark the current index being checked in purple
      currentIndex = i;
      updateMessage('Checking ${array[i]}');

      await Future.delayed(Duration(milliseconds: (1200 ~/ speed)));
      setState(() {});

      while (j >= 0 && array[j] > key && isSorting) {
        // Move elements greater than key one position ahead
        array[j + 1] = array[j];
        j = j - 1;
      }

      array[j + 1] = key; // Insert key into the sorted part

      // Mark the sorted index in green
      sortedIndex = i;
      updateMessage('Inserting ${array[i]} into the sorted array');

      await Future.delayed(Duration(milliseconds: (1200 ~/ speed)));
      setState(() {});
    }

    // Reset indices and message after sorting is complete or stopped
    currentIndex = -1;
    sortedIndex = -1;
    if (isSorting) {
      updateMessage('It is Sorted Now');
    } else {
      updateMessage('Sorting Stopped');
    }
    showPrompt = true; // Show prompt after sorting is complete
    isSorting = false;
    setState(() {});
  }

  void updateMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertion Sort Visualization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: maxBarHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: array.map((value) {
                    double percentage = value / 100.0;
                    Color color = Colors.blue;
                    if (currentIndex == array.indexOf(value)) {
                      color = Colors.purple; // Mark current index in purple
                    }
                    if (sortedIndex >= 0 && array.indexOf(value) <= sortedIndex) {
                      color = Colors.green; // Mark sorted index in green
                    }
                    return Container(
                      width: barWidth,
                      height: maxBarHeight,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: barWidth,
                              height: maxBarHeight * percentage,
                              color: color,
                              child: Center(
                                child: Text(
                                  '$value',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!isSorting) {
                  insertionSort();
                } else {
                  stopSorting();
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Text(isSorting ? 'Stop' : 'Sort'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateArray();
              },
              style: ElevatedButton.styleFrom(primary: Colors.white),
              child: Text('Generate'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Speed: '),
                Slider(
                  value: speed.toDouble(),
                  min: 1,
                  max: 5,
                  onChanged: (value) {
                    setState(() {
                      speed = value.toInt();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                message,
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
