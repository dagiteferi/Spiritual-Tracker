import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert'; // Import for JSON handling

class PrayerRequestPage extends StatefulWidget {
  const PrayerRequestPage({super.key});

  @override
  State<PrayerRequestPage> createState() => _PrayerRequestPageState();
}

class _PrayerRequestPageState extends State<PrayerRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _requestController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _requestController.dispose();
    super.dispose();
  }
Future<void> _submitRequest() async {
  if (_formKey.currentState!.validate()) {
    final name = _nameController.text.isEmpty ? "Anonymous" : _nameController.text;
    final request = _requestController.text;

    // Prepare data to send to PHP backend
    final data = {
      'name': name,
      'request': request,
    };

    // Send the prayer request to the backend via POST
    final response = await http.post(
      Uri.parse('http://localhost/prayer_api/request_event.php'), // Change URL if necessary
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['success'] == true) {
        // If successful, navigate to the Prayer Requests List page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrayerRequestsListPage(
              newRequest: {
                'name': name,
                'request': request,
                'created_at': DateTime.now().toIso8601String(),
              },
            ),
          ),
        );
      } else {
        // Show error message if not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save request: ${result['error']}')),
        );
      }
    } else {
      // Handle network errors or bad responses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Unable to connect to server')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Request',style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 88, 81, 81),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchForPrayerRequests(),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 81, 82, 84),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'We\'re Here to Pray With You',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Submit Your Prayer Request:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name (Optional)',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _requestController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Your Prayer Request',
                      prefixIcon: Icon(Icons.message),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Prayer request cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitRequest,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: const Color.fromARGB(255, 77, 77, 78),
                    ),
                    child: const Text(
                      'Submit Prayer Request',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Follow Us for Prayer Support:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.facebook),
                  color: Colors.blue,
                  onPressed: () {
                    _launchURL('https://www.facebook.com/Nehmya-Biruk');
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  color: Colors.lightBlue,
                  onPressed: () {
                    _launchURL('https://www.twitter.com');
                  },
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram),
                  color: Colors.pink,
                  onPressed: () {
                    _launchURL('https://www.instagram.com/nehmya_biruk/');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SearchForPrayerRequests extends StatelessWidget {
  const SearchForPrayerRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrayerRequestsListPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.search, color: Color.fromARGB(255, 82, 83, 85)),
            const SizedBox(width: 8),
            const Text(
              'Search for Prayer Requests',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 73, 76, 80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PrayerRequestsListPage extends StatefulWidget {
  final Map<String, dynamic>? newRequest; // To handle the new request

  const PrayerRequestsListPage({super.key, this.newRequest});

  @override
  State<PrayerRequestsListPage> createState() => _PrayerRequestsListPageState();
}

class _PrayerRequestsListPageState extends State<PrayerRequestsListPage> {
  List<dynamic> _prayerRequests = [];
  List<dynamic> _filteredRequests = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPrayerRequests();

    // Set up listener for search bar input
    _searchController.addListener(() {
      _filterRequests(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPrayerRequests() async {
    final response = await http.get(
      Uri.parse('http://localhost/prayer_api/search_events.php'), // Change URL if necessary
    );

    if (response.statusCode == 200) {
      setState(() {
        _prayerRequests = json.decode(response.body);
        _filteredRequests = _prayerRequests; // Initially show all requests

        if (widget.newRequest != null) {
          // Add the new request into the list if it's provided
          _prayerRequests.insert(0, widget.newRequest);
          _filteredRequests = _prayerRequests; // Update the filtered list as well
        }
      });
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }

  void _filterRequests(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRequests = _prayerRequests;
      } else {
        _filteredRequests = _prayerRequests
            .where((request) =>
                (request['name'] ?? 'Anonymous').toLowerCase().contains(query.toLowerCase()) ||
                request['request'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Requests'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Prayer Requests',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredRequests.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = _filteredRequests[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(request['name'] ?? 'Anonymous'),
                            subtitle: Text(request['request']),
                            trailing: Text(request['created_at']),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
