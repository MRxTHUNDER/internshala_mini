import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/application_screen.dart';

class InternshipDetailsScreen extends StatelessWidget {
  final Internship internship;

  const InternshipDetailsScreen({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 151, 194),
        title: const Text('Internships Details', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Title: ${internship.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
             Text(' ${internship.companyName}', style: const TextStyle(fontSize: 18, color:  Color.fromARGB(255, 138, 137, 137))),

             const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 5,),
                Text('Location: ${internship.workFromHome ? 'Work From Home' : internship.locationNames.join(', ')}', style: const TextStyle(fontSize: 18)),
              ]),
            ),
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 5,),
                Text('Start Date: ${internship.startDate}', style: const TextStyle(fontSize: 18)),
              ]),
            ),
            
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const Icon(Icons.timeline),
                const SizedBox(width: 5,),
                Text('Duration: ${internship.duration}', style: const TextStyle(fontSize: 18)),
              ]),
            ),
            
            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const Icon(Icons.monetization_on),
                const SizedBox(width: 5,),
                Text('Stipend: ${internship.stipend}', style: const TextStyle(fontSize: 18)),
              ]),
            ),
            
            const SizedBox(height: 10),
            
            const SizedBox(height: 20),
            Text.rich(
                  TextSpan(
                    text: 'Posted On:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // default text style
                    children: <TextSpan>[
                      TextSpan(text: ' ${internship.postedOn} ', style: const TextStyle( fontSize: 18, color: Color.fromARGB(255, 138, 178, 185))),
                    ],
                  ),
                ),
            //Text('Posted On: ${internship.postedOn}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text.rich(
                  TextSpan(
                    text: 'Application Deadline:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // default text style
                    children: <TextSpan>[
                      TextSpan(text: ' ${internship.applicationDeadline} ', style: const TextStyle( fontSize: 18, color: Color.fromARGB(255, 138, 178, 185))),
                    ],
                  ),
                ),
            //Text('Application Deadline: ${internship.applicationDeadline}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text.rich(
                  TextSpan(
                    text: 'PPO Avaliable:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // default text style
                    children: <TextSpan>[
                      TextSpan(text: ' ${internship.isPpo ? 'Yes' : 'No'} ', style: const TextStyle( fontSize: 18, color: Color.fromARGB(255, 138, 178, 185))),
                    ],
                  ),
                ),
            //Text('PPO Avaliable: ${internship.isPpo ? 'Yes' : 'No'}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('About Internship:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            
            Container(
              //color: Colors.brown,
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              child: Text('As an intern at ${internship.companyName}, you will gain invaluable experience working with a dynamic team on cutting-edge projects. Our internship program is designed to provide you with hands-on experience and exposure to real-world challenges in the [industry/field]. You will have the opportunity to collaborate with experienced professionals, enhance your skills, and contribute to meaningful work.', 
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 20),
            
            Center(

              child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                 side: BorderSide(color: Colors.black, width: 1),
                 elevation: 20,
                 minimumSize: Size(150,50),
                 shadowColor: Colors.teal,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed:() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationScreen(internship: internship),
                      ),
                    );
              },
              child: Text("Apply"),
            )
              // child: ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ApplicationScreen(internship: internship),
              //         ),
              //       );
              //   },
              //   child: Text('Apply'),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
