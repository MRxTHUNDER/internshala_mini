import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/models/internship.dart';
import 'package:internshala_mini_clone/screens/custom_search_delegate.dart';
import 'package:internshala_mini_clone/services/api_service.dart';
import 'package:internshala_mini_clone/screens/search_screen.dart';
import 'package:internshala_mini_clone/screens/filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Internship>> futureInternships;

  @override
  void initState() {
    super.initState();
    futureInternships = ApiService().fetchInternships();
  }

  void _searchInternships(String query, {Map<String, String>? filters}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(query: query, filters: filters),
      ),
    );
  }

  void _openFilterScreen() async {
    final filters = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FilterScreen(),
      ),
    );

    if (filters != null) {
      _searchInternships('', filters: filters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 10, 151, 194),
        title: const Text('Internships', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          InkWell(
            child: IconButton(
              icon: const Icon(Icons.search, size: 30, color: Colors.white,),
              tooltip: 'Search Icon',
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(onSearch: (query) => _searchInternships(query)),
                );
              },
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: IconButton(
                icon: const Icon(Icons.filter_alt_sharp, size: 25, color: Colors.white,),
                onPressed: _openFilterScreen,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark, size: 25, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Internship>>(
        future: futureInternships,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No internships found'));
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