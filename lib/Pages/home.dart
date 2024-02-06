import 'package:flutter/material.dart';
import '../categories/search_page.dart';
import '../categories/sort_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Algorithms',
        style: TextStyle(color: Colors.white),),

        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16),
        childAspectRatio: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          CategoryContainer(
            categoryName: 'Searching',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          CategoryContainer(
            categoryName: 'Sorting',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SortPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;

  CategoryContainer({required this.categoryName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.9),
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
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                categoryName,
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
    home: HomeScreen(),
  ));
}
