import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProfile;
  String? _selectedCity;
  String? _selectedDuration;

  void _applyFilters() {
    final filters = {
      'profile': _selectedProfile ?? '',
      'city': _selectedCity ?? '',
      'duration': _selectedDuration ?? '',
    };

    Navigator.pop(context, filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 151, 194),
        title: const Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: _applyFilters,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Profile'),
                value: _selectedProfile,
                items: ['Software Engineer', 'Data Analyst', 'Designer']
                    .map((profile) => DropdownMenuItem(
                          value: profile,
                          child: Text(profile),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProfile = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'City'),
                value: _selectedCity,
                items: ['Delhi', 'Mumbai', 'Bangalore']
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Duration'),
                value: _selectedDuration,
                items: ['1 Month', '2 Months', '3 Months']
                    .map((duration) => DropdownMenuItem(
                          value: duration,
                          child: Text(duration),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDuration = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _applyFilters,
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
