import 'package:flutter/material.dart';

import '../search/binary.dart';
import '../search/linear.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Searching Algorithms',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlgorithmContainer(
              algorithmName: 'Linear Search',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LinearPage()),
                );
              },
            ),
            SizedBox(height: 25),
            AlgorithmContainer(
              algorithmName: 'Binary Search',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BinarySearchPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlgorithmContainer extends StatelessWidget {
  final String algorithmName;
  final VoidCallback onTap;

  AlgorithmContainer({required this.algorithmName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Center(
              child: Text(
                algorithmName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}
