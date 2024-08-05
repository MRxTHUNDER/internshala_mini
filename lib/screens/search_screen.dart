import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/filter_screen.dart';
import 'package:internshala_mini_clone/services/api_service.dart';
import 'package:internshala_mini_clone/screens/internship_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  final Map<String, String>? filters;

  SearchScreen({required this.query, this.filters});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Internship>> futureInternships;

  @override
  void initState() {
    super.initState();
    futureInternships = ApiService().fetchInternshipsWithFilters(widget.filters ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 151, 194),
        title: Text('Search Results', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterScreen(),
                ),
              ).then((filters) {
                if (filters != null) {
                  setState(() {
                    futureInternships = ApiService().fetchInternshipsWithFilters(filters);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Internship>>(
        future: futureInternships,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No matching internships found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InternshipCard(internship: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}

class InternshipCard extends StatelessWidget {
  final Internship internship;

  const InternshipCard({required this.internship});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: const Color.fromARGB(255, 179, 221, 255),
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(internship.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(internship.companyName, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(internship.workFromHome ? 'Work From Home' : internship.locationNames.join(', ')),
            SizedBox(height: 10),
            Text('Start Date: ${internship.startDate}'),
            SizedBox(height: 10),
            Text('Duration: ${internship.duration}'),
            SizedBox(height: 10),
            Text('Stipend: ${internship.stipend}'),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                 side: BorderSide(color: Colors.black, width: 1),
                 elevation: 20,
                 minimumSize: Size(150,50),
                 shadowColor: Colors.teal,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
               ),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InternshipDetailsScreen(internship: internship),
                    ),
                  );
                },
              child: Text("Apply Now"),
            )
              
            ),
          ],
        ),
      ),
    );
  }
}
