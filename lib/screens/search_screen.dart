import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/models/internship.dart';
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
    futureInternships = ApiService().fetchInternships(); // Fetch internships as usual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Internship>>(
        future: futureInternships,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No internships found'));
          } else {
            List<Internship> filteredInternships = snapshot.data!.where((internship) {
              bool matchesQuery = internship.title.toLowerCase().contains(widget.query.toLowerCase()) ||
                                   internship.companyName.toLowerCase().contains(widget.query.toLowerCase());
              bool matchesFilters = true;

              if (widget.filters != null) {
                final filters = widget.filters!;
                if (filters['profile'] != null && internship.title != filters['profile']) {
                  matchesFilters = false;
                }
                if (filters['city'] != null && !internship.locationNames.contains(filters['city'])) {
                  matchesFilters = false;
                }
                if (filters['duration'] != null && internship.duration != filters['duration']) {
                  matchesFilters = false;
                }
              }

              return matchesQuery && matchesFilters;
            }).toList();

            if (filteredInternships.isEmpty) {
              return Center(child: Text('No matching internships found'));
            }

            return ListView.builder(
              itemCount: filteredInternships.length,
              itemBuilder: (context, index) {
                return InternshipCard(internship: filteredInternships[index]);
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InternshipDetailsScreen(internship: internship),
                    ),
                  );
                },
                child: Text('Apply Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
