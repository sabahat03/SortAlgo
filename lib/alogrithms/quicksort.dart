import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class QuickSortPage extends StatefulWidget {
  @override
  _QuickSortPageState createState() => _QuickSortPageState();
}

class _QuickSortPageState extends State<QuickSortPage> {
  List<int> array = [];
  double maxBarHeight = 215.0;
  double barWidth = 40.0;
  int speed = 3; // Set the default speed to 3
  int pivotIndex = -1;
  int currentIndex = -1;
  int endIndex = -1;
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
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < 8) {
      uniqueNumbers.add(random.nextInt(100) + 1);
    }

    array = uniqueNumbers.toList();
    pivotIndex = -1;
    currentIndex = -1;
    endIndex = array.length - 1;
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
            'Quick Sort',
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
                'Worst Case: O(n^2)\nAverage Case: O(n log n)\nBest Case: O(n log n)',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                'Definition:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Quick Sort is a divide-and-conquer algorithm. It works by selecting a pivot element and partitioning the other elements into two sub-arrays according to whether they are less than or greater than the pivot. The sub-arrays are then sorted recursively.',
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

  Future<void> quickSort(int low, int high) async {
    if (low < high && isSorting) {
      int partitionIndex = await partition(low, high);

      await quickSort(low, partitionIndex - 1);
      await quickSort(partitionIndex + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    int pivotValue = array[high];
    pivotIndex = high;
    int i = low - 1;

    for (int j = low; j < high; j++) {
      currentIndex = j;
      updateMessage('Selecting pivot value ${array[pivotIndex]}');

      await Future.delayed(Duration(milliseconds: (1200 ~/ speed)));
      setState(() {});

      if (array[j] < pivotValue) {
        i++;
        // Swap array[i] and array[j]
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
      }
    }

    // Swap array[i+1] and array[high] (or pivot)
    int temp = array[i + 1];
    array[i + 1] = array[high];
    array[high] = temp;

    // Update pivotIndex to the final sorted position
    pivotIndex = i + 1;

    // Reset currentIndex after partitioning
    currentIndex = -1;

    return i + 1;
  }

  Future<void> startQuickSort() async {
    hidePrompt(); // Hide prompt when sorting starts
    isSorting = true;
    await quickSort(0, array.length - 1);
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
        title: Text('Quick Sort Visualization'),
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
                    if (array.indexOf(value) == pivotIndex) {
                      color = Colors.orange; // Mark pivot index in orange
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
                  startQuickSort();
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
