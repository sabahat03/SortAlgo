import 'dart:math';
import 'package:flutter/material.dart';

class BinarySearchPage extends StatefulWidget {
  @override
  _BinarySearchPageState createState() => _BinarySearchPageState();
}

class _BinarySearchPageState extends State<BinarySearchPage> {
  List<int> numbers = [];
  TextEditingController _searchController = TextEditingController();
  int? target;
  int? foundIndex;
  double speed = 1.0; // Default speed
  bool notFound = false;

  @override
  void initState() {
    super.initState();
    generateSortedNumbers();
  }

  // Function to generate a sorted list of unique numbers
  void generateSortedNumbers() {
    setState(() {
      Random random = Random();
      Set<int> uniqueNumbers = Set<int>();

      // Generate unique random numbers between 1 and 100
      while (uniqueNumbers.length < 15) {
        uniqueNumbers.add(random.nextInt(100) + 1);
      }

      // Convert the set to a list and sort it
      numbers = uniqueNumbers.toList();
      numbers.sort();

      foundIndex = null;
      notFound = false;
    });
  }

  // Function to perform binary search
  Future<void> binarySearch() async {
    // Check if a valid number is entered
    if (_searchController.text.isEmpty) {
      // Show an error prompt
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a number before searching.'),
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

    int low = 0;
    int high = numbers.length - 1;

    while (low <= high) {
      // Calculate mid index
      int mid = (low + high) ~/ 2;

      // Highlight mid for visualization
      setState(() {
        target = int.tryParse(_searchController.text);
        foundIndex = mid;
      });

      // Simulating delay for visualization based on the speed
      await Future.delayed(Duration(milliseconds: (500 ~/ speed).round()));

      // If target found, update state and exit the loop
      if (numbers[mid] == target) {
        setState(() {
          foundIndex = mid;
          notFound = false;
        });
        return;
      } else if (numbers[mid] < target!) {
        // If target is greater, eliminate the left half of the array
        low = mid + 1;
      } else {
        // If target is smaller, eliminate the right half of the array
        high = mid - 1;
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
        title: Text('Binary Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the numbers in a responsive grid
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width ~/ 50,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: numbers.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                  color: foundIndex != null && index == foundIndex
                      ? Colors.green
                      : index == target
                      ? Colors.blue
                      : Colors.blue,
                ),
                child: Center(
                  child: Text(
                    numbers[index].toString(),
                    style: TextStyle(
                      color: index == target ? Colors.white : Colors.white,
                    ),
                  ),
                ),
              ),
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
                await binarySearch();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    generateSortedNumbers();
                  },
                  child: Text('Generate'),
                ),
              ],
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
