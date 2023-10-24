import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CollegeListScreen.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MyApp());
}

// ... College class definition here ...
class College {
  final String name;
  final String caste;
  final String gender;
  final String branch;
  final int cutoffRank;
  final int tuitionFee;

  College(this.name, this.caste, this.gender, this.branch, this.cutoffRank, this.tuitionFee);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My College Compass',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        hintColor: Colors.lightGreen,

      ),
      home: CollegeFilterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CollegeFilterScreen extends StatefulWidget {
  @override
  _CollegeFilterScreenState createState() => _CollegeFilterScreenState();
}

class _CollegeFilterScreenState extends State<CollegeFilterScreen> {
  // ... Existing code for user inputs, filtering, and button ...
  final List<College> colleges = [
    College('ANURAG ENGINEERING COLLEGE AUTONOMOUS', 'OC', 'Male','CSE', 100, 10000),
    College('BHARAT INSTITUTE OF ENGG AND TECHNOLOGY', 'OC', 'Female','IT', 105, 25000),
    College('B V RAJU INSTITUTE OF TECHNOLOGY', 'BC', 'Male','ECE', 110, 20000),
    College('CHAITANYA BHARATHI INSTITUTE OF TECHNOLOGY', 'BC', 'Female','EEE', 115, 25000),
    College('AAR MAHAVEER ENGINEERING COLLEGE', 'SC', 'Male','EIE', 120, 30000),
    College('CVR COLLEGE OF ENGINEERING', 'SC','Male','AIML',145, 36000),
    College('ANURAG ENGINEERING COLLEGE AUTONOMOUS', 'SC','Male','CSE',140, 40000),
    College('BHARAT INSTITUTE OF ENGG AND TECHNOLOGY', 'SC','Male','IT',135, 45000),
    College('B V RAJU INSTITUTE OF TECHNOLOGY', 'SC','Male','EEE',130, 50000),
    College('CHAITANYA BHARATHI INSTITUTE OF TECHNOLOGY', 'SC','Male','DS',144, 30000),
    College('VASAVI COLLEGE OF ENGINEERING', 'SC','Male','ET',125, 45000),
    College('GURUNANAK INST OF TECHNOLOGY', 'SC','Male','DS',128, 50000),
    College('JNTUH UNIVERSITY COLLEGE OF ENGG  HYDERABAD', 'SC','Male','AIML',130, 40000),
    College('KESHAV MEMORIAL INST OF TECHNOLOGY', 'SC','Male','CS',135, 30000),
    College('GURUNANAK INST OF TECHNOLOGY', 'SC', 'Female','CS', 125, 25000),
    College('JNTUH UNIVERSITY COLLEGE OF ENGG  HYDERABAD', 'ST', 'Male','CSIT', 130, 35000),
    College('KESHAV MEMORIAL INST OF TECHNOLOGY', 'ST', 'Female','ET', 135, 40000),
    College('MALLA REDDY COLLEGE OF ENGG  TECHNOLOGY', 'EWS', 'Male','AIDS', 140, 45000),
    College('VASAVI COLLEGE OF ENGINEERING', 'EWS', 'Female','DS', 145,40000),
    // Add more colleges here...
  ];

  String userCaste = 'OC'; // Default caste value
  String userGender = 'Male'; // Default gender value
  int userEamcetRank = 0;
  String? _eamcetRankError; // Declare this variable globally in your widget state
  TextEditingController _eamcetRankController = TextEditingController();
  bool isTyping = false;

  List<College> filteredColleges = [];
  void filterColleges() {
    // ... Existing code for filtering colleges ...
    setState(() {
      filteredColleges = colleges.where((college) {
        return college.caste == userCaste &&
            college.gender == userGender &&
            userEamcetRank <= college.cutoffRank;
      }).toList();
    });

    // Navigate to the CollegeListScreen with filteredColleges
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollegeListScreen(filteredColleges: filteredColleges),
      ),
    );
  }

  // bool _validateInputs() {
  //   if (_eamcetRankController.text.isEmpty) {
  //     // If EAMCET rank is not entered
  //     setState(() {
  //       _eamcetRankError = 'EAMCET rank is required';
  //     });
  //     return false;
  //   }
  //   // Add more validation logic if needed
  //
  //
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My College Compass'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Your Details:'),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                LengthLimitingTextInputFormatter(6), // Limit input to 6 characters
              ],
              onChanged: (value) {
                setState(() {
                  isTyping = value.isNotEmpty; // Update typing status
                  if (int.tryParse(value) == null) {
                    _eamcetRankError = 'Please enter valid numbers only';
                  } else {
                    _eamcetRankError = null; // Clear the error message if the input is valid
                    userEamcetRank = int.tryParse(value) ?? 0;
                  }
                });
              },
              decoration: InputDecoration(labelText: 'EAMCET Rank',errorText: _eamcetRankError),
            ),
            DropdownButtonFormField<String>(
              value: userCaste,
              onChanged: (value) {
                setState(() {
                  userCaste = value!;
                });
              },
              items: ['OC', 'BC', 'SC', 'ST', 'EWS']
                  .map((caste) => DropdownMenuItem(
                value: caste,
                child: Text(caste),
              ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Caste'),
            ),
            DropdownButtonFormField<String>(
              value: userGender,
              onChanged: (value) {
                setState(() {
                  userGender = value!;
                });
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
                  .toList(),
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isTyping ? filterColleges : null, // Enable button if input is valid and user is typing
              child: Text('Submit'),
            ),

          ],
        ),
      ),
    );
  }
}
