import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailsScreen({super.key, required this.item});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            widget.item['title'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: () {

              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(item: widget.item),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      widget.item['image'],
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item['title'],
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.item['description'],
                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'See More',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Suggestions',
                      style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 190,
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: _fetchDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Lottie.asset(
                                'assets/animation.json', // Replace with your Lottie animation URL
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            final List<Map<String, dynamic>> data = snapshot.data!;
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                              ),
                              scrollDirection: Axis.horizontal,

                              padding: const EdgeInsets.all(10.0),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
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
                                          padding: const EdgeInsets.only(left: 5, bottom: 10),
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
                                                  fontWeight: FontWeight.bold,
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
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Landscape mode layout
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            widget.item['title'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              onPressed: () {

              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    widget.item['image'],
                    width: double.infinity,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Description on the right side
                      Text(
                        widget.item['title'],
                        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.item['description'],
                        style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'See More',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Suggestions',
                        style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16.0),
                      // GridView for suggestions
                      SizedBox(
                        height: 175,
                        child: FutureBuilder<List<Map<String, dynamic>>>(
                          future: _fetchDataFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: Lottie.asset(
                                  'assets/animation.json', // Replace with your Lottie animation URL
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              final List<Map<String, dynamic>> data = snapshot.data!;
                              return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                ),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(10.0),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final item = data[index];
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
                                            padding: const EdgeInsets.only(left: 5, bottom: 10),
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
                                                    fontWeight: FontWeight.bold,
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
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
