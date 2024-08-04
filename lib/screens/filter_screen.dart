import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/screens/search_screen.dart';
import 'package:internshala_mini_clone/services/api_service.dart';
import 'package:internshala_mini_clone/models/internship.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProfile;
  String? _selectedCity;
  String? _selectedDuration;
  List<Internship> _filteredInternships = [];
  bool _isLoading = false;

  void _applyFilters() async {
    setState(() {
      _isLoading = true;
    });

    final filters = {
      'profile': _selectedProfile,
      'city': _selectedCity,
      'duration': _selectedDuration,
    };

    try {
      final apiService = ApiService();
      final internships = await apiService.fetchInternshipsWithFilters(filters);

      setState(() {
        _filteredInternships = internships;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching internships')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _applyFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Profile'),
                    value: _selectedProfile,
                    items: ['Data Science', 'Engineering', 'Design']
                        .map((profile) => DropdownMenuItem(
                              child: Text(profile),
                              value: profile,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProfile = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'City'),
                    value: _selectedCity,
                    items: ['Delhi', 'Mumbai', 'Bangalore']
                        .map((city) => DropdownMenuItem(
                              child: Text(city),
                              value: city,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Duration'),
                    value: _selectedDuration,
                    items: ['1 Month', '3 Months', '6 Months']
                        .map((duration) => DropdownMenuItem(
                              child: Text(duration),
                              value: duration,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDuration = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_filteredInternships.isEmpty)
            Expanded(
              child: Center(child: Text('No internships found')),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _filteredInternships.length,
                itemBuilder: (context, index) {
                  return InternshipCard(internship: _filteredInternships[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}
