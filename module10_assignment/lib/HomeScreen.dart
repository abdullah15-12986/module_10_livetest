import 'package:flutter/material.dart';
import 'package:module10_assignment/DetailsScreen.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://alsaaditsolution.com/photogallery/abdullah.json'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'My Photo Gallery',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.cyan,
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset(
                    'assets/animation.json', // Replace with your Lottie animation URL
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<Map<String, dynamic>> data = snapshot.data!;
                int crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
                return GridView.builder(
                  padding: const EdgeInsets.all(20.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return FutureBuilder(
                      future: Future.delayed(const Duration(milliseconds: 300)), // Simulating loading delay
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                              'assets/animation.json', // Replace with your Lottie animation URL
                              width: 100, // Lottie Width
                              height: 100, // Lottie height
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(item: item),
                                ),
                              );
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  image: DecorationImage(
                                    image: NetworkImage(item['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          item['title'],
                                          style: const TextStyle(
                                            color: Colors.white,

                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
