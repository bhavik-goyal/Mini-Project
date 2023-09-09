import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class College {
  final String name;
  final int cutoffRank;
  final String gender;
  final String caste;

  College(this.name, this.cutoffRank, this.gender, this.caste);
}

class CollegeListScreen extends StatefulWidget {
  @override
  _CollegeListScreenState createState() => _CollegeListScreenState();
}

class _CollegeListScreenState extends State<CollegeListScreen> {
  List<College> colleges = [];

  @override
  void initState() {
    super.initState();
    loadCollegeData();
  }

  Future<void> loadCollegeData() async {
    String csvData = await rootBundle.loadString('assets/colleges_list_2022.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);

    for (var row in csvTable) {
      colleges.add(College(row[0], int.parse(row[1]), row[2], row[3]));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colleges List'),
      ),
      body: ListView.builder(
        itemCount: colleges.length,
        itemBuilder: (context, index) {
          final college = colleges[index];
          return ListTile(
            title: Text(college.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cutoff Rank: ${college.cutoffRank}'),
                Text('Gender: ${college.gender}'),
                Text('Caste: ${college.caste}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
