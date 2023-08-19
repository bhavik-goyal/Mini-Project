import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _selectedGender = 'Male'; // Default value
  String _selectedCaste = 'General'; // Default value
  TextEditingController _rankController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> casteOptions = ['General', 'SC', 'ST', 'OBC', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My College Compass'),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        color: Colors.lightGreen[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _rankController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Enter EAMCET Rank',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Gender',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: genderOptions.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Caste',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: _selectedCaste,
                  items: casteOptions.map((caste) {
                    return DropdownMenuItem<String>(
                      value: caste,
                      child: Text(caste),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCaste = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Process the data here, e.g., save to database, show results, etc.
                String rank = _rankController.text;
                print('EAMCET Rank: $rank');
                print('Gender: $_selectedGender');
                print('Caste: $_selectedCaste');

              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change the background color here
              ),
              child: const Text('Submit'),

            ),
          ],
        ),
      ),
    );
  }
}
