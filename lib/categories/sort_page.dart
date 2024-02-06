import 'package:flutter/material.dart';
import 'package:first_app/alogrithms/selectionsort.dart';
import 'package:first_app/alogrithms/bubblesort.dart';
import 'package:first_app/alogrithms/insertionsort.dart';
import 'package:first_app/alogrithms/quicksort.dart';

class SortPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Algorithms',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AlgorithmContainer(
                algorithmName: 'Bubble Sort',
                iconData: Icons.bubble_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BubbleSortPage()),
                  );
                },
              ),
              SizedBox(height: 16),
              AlgorithmContainer(
                algorithmName: 'Insertion Sort',
                iconData: Icons.insert_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsertionSortPage()),
                  );
                },
              ),
              SizedBox(height: 16),
              AlgorithmContainer(
                algorithmName: 'Selection Sort',
                iconData: Icons.select_all,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectionSortPage()),
                  );
                },
              ),
              SizedBox(height: 16),
              AlgorithmContainer(
                algorithmName: 'Quick Sort',
                iconData: Icons.speed,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuickSortPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlgorithmContainer extends StatelessWidget {
  final String algorithmName;
  final IconData iconData;
  final VoidCallback onTap;

  const AlgorithmContainer({
    required this.algorithmName,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 48,
            ),
            SizedBox(height: 8),
            Text(
              algorithmName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
