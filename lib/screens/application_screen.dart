import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/home_screen.dart';

class ApplicationScreen extends StatefulWidget {
  final Internship internship;

  const ApplicationScreen({required this.internship});

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final _coverLetterController = TextEditingController();
  bool _relocationAvailability = false;
  String? _resumePath;

  void _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _resumePath = result.files.single.path;
      });
    }
  }

  void _submitApplication(BuildContext context) {
    // Clear the resume path as the backend functionality is not implemented
    setState(() {
      _resumePath = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Application Submitted')));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 151, 194),
        title: Text(widget.internship.title , style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cover Letter ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20),
              TextField(
                controller: _coverLetterController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Cover Letter',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text("Location ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              Row(
                children: [
                  Checkbox(
                    value: _relocationAvailability,
                    onChanged: (value) {
                      setState(() {
                        _relocationAvailability = value!;
                      });
                    },
                  ),
                  Text('Are you available to Relocate'),
                ],
              ),
              SizedBox(height: 20),
              Text("Resume ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              ElevatedButton(
                onPressed: _pickResume,
                child: Text(_resumePath == null ? 'Upload Resume' : 'Resume Uploaded'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                 side: BorderSide(color: Colors.black, width: 1),
                 elevation: 20,
                 minimumSize: Size(150,50),
                 shadowColor: Colors.teal,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed: () => _submitApplication(context),
              child: Text("Submit"),
            )
                // child: ElevatedButton(
                //   onPressed: () => _submitApplication(context),
                //   child: Text('Submit'),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
