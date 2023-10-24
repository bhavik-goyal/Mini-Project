import 'package:flutter/material.dart';

import 'main.dart';

class CollegeListScreen extends StatelessWidget {
  final List<College> filteredColleges;

  CollegeListScreen({required this.filteredColleges});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Colleges'),
      ),
      body: ListView.builder(
        itemCount: filteredColleges.length,
        itemBuilder: (context, index) {
          final college = filteredColleges[index];
          return ListTile(
            title: Text(college.name),
            subtitle: Text('Cutoff Rank: ${college.cutoffRank}'+'   '+' Branch: ${college.branch}'+'   '+'Tution Fee: ${college.tuitionFee}'),
          );
        },
      ),
    );
  }
}
