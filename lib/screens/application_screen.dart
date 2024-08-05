import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/home_screen.dart';

class ApplicationScreen extends StatefulWidget {
  final Internship internship;

  const ApplicationScreen({super.key, required this.internship});

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
    
    setState(() {
      _resumePath = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Application Submitted')));
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 151, 194),
        title: Text(widget.internship.title , style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cover Letter ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 20),
              TextField(
                controller: _coverLetterController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Cover Letter',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Location ", style: TextStyle(
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
                  const Text('Are you available to Relocate'),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Resume ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              ElevatedButton(
                onPressed: _pickResume,
                child: Text(_resumePath == null ? 'Upload Resume' : 'Resume Uploaded'),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: Colors.black, width: 1),
                 elevation: 20,
                 minimumSize: const Size(150,50),
                 shadowColor: Colors.teal,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed: () => _submitApplication(context),
              child: const Text("Submit"),
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
