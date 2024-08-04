import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/application_screen.dart';

class InternshipDetailsScreen extends StatelessWidget {
  final Internship internship;

  InternshipDetailsScreen({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${internship.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Company: ${internship.companyName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Location: ${internship.workFromHome ? 'Work From Home' : internship.locationNames.join(', ')}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Start Date: ${internship.startDate}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Duration: ${internship.duration}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Stipend: ${internship.stipend}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Posted On: ${internship.postedOn}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Application Deadline: ${internship.applicationDeadline}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('PPO: ${internship.isPpo ? 'Yes' : 'No'}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('About Internship:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Placeholder for internship description...', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationScreen(internship: internship),
                      ),
                    );
                },
                child: Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
