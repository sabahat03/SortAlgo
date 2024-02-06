import 'dart:math';

import 'package:flutter/material.dart';

class BubbleSortPage extends StatefulWidget {
  @override
  _BubbleSortPageState createState() => _BubbleSortPageState();
}

class _BubbleSortPageState extends State<BubbleSortPage> {
  List<int> array = [];
  double maxBarHeight = 215.0;
  double barWidth = 40.0;
  int speed = 1; // Adjusted default speed to be slower
  int comparisonIndex = -1;
  int swapIndex = -1;
  String message = '';
  bool showPrompt = true;
  bool sortingInProgress = false; // Track whether sorting is in progress

  @override
  void initState() {
    super.initState();
    generateArray();
  }

  void generateArray() {
    final random = Random();
    array = List.generate(8, (index) => random.nextInt(100) + 1);
    comparisonIndex = -1;
    swapIndex = -1;
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
            'Bubble Sort',
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
                'Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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

  Future<void> bubbleSort() async {
    if (sortingInProgress) return; // Do not start a new sorting if one is already in progress

    sortingInProgress = true; // Set flag to indicate sorting is in progress
    int n = array.length;

    hidePrompt(); // Hide prompt when sorting starts

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        // Check if sorting should be stopped
        if (!sortingInProgress) return;

        // Mark the compared elements in green
        comparisonIndex = j;
        swapIndex = j + 1;
        updateMessage('Comparing ${array[j]} and ${array[j + 1]}');

        await Future.delayed(Duration(milliseconds: (1200 ~/ speed)));
        setState(() {});

        if (array[j] > array[j + 1]) {
          // Swap elements
          int temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;

          // Mark the swapped elements in red
          swapIndex = j;
          updateMessage('Swapping ${array[j]} and ${array[j + 1]}');

          await Future.delayed(Duration(milliseconds: (1200 ~/ speed)));
          setState(() {});
        }
      }
    }
    // Reset indices and message after sorting is complete
    comparisonIndex = -1;
    swapIndex = -1;
    updateMessage('Yes, it is Sorted Now');
    showPrompt = true; // Show prompt after sorting is complete
    sortingInProgress = false; // Reset flag to indicate sorting is complete
    setState(() {});
  }

  void updateMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  // New method to stop the sorting process
  void stopSorting() {
    setState(() {
      sortingInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bubble Sort Visualization'),
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
                    if (comparisonIndex == array.indexOf(value) ||
                        swapIndex == array.indexOf(value)) {
                      color = Colors.green; // Mark compared elements in green
                    }
                    if (swapIndex == array.indexOf(value)) {
                      color = Colors.red; // Mark swapped elements in red
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
                sortingInProgress ? stopSorting() : bubbleSort();
              },
              child: Text(sortingInProgress ? 'Stop' : 'Sort'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateArray();
              },
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
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

