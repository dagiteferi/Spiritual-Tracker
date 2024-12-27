import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neh/homepage/devotions/devotions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ChurchCalendarPage extends StatelessWidget {
  const ChurchCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Church Calendar'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Church Calendar',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 30.0),
            // Request Church Events Button
            Card(
              elevation: 5.0,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestChurchEventsPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.event_available,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        'Request Church Events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Search Church Events Button
            Card(
              elevation: 5.0,
              color: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchChurchEventsPage(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search, color: Colors.white, size: 35.0),
                      SizedBox(width: 20.0),
                      Text(
                        'Search Church Events',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestChurchEventsPage extends StatefulWidget {
  const RequestChurchEventsPage({super.key});

  @override
  _RequestChurchEventsPageState createState() =>
      _RequestChurchEventsPageState();
}

class _RequestChurchEventsPageState extends State<RequestChurchEventsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Function to submit event data
  Future<void> _submitEvent() async {
    final String name = _nameController.text;
    final String description = _descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Send data to the PHP script
      final response = await http.post(
        Uri.parse('http://192.168.1.13/church_api/save_event.php'),
        body: {
          'name': name,
          'description': description,
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Server response: $responseBody');

        final snackBarMessage = responseBody['success']
            ? 'Event submitted successfully!'
            : 'Failed to submit event!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(snackBarMessage)),
        );

        // Clear the text fields on success
        if (responseBody['success']) {
          _nameController.clear();
          _descriptionController.clear();
        }
      } else {
        print('Server responded with status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error. Please try again later.')),
        );
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Unable to connect to the server.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Church Events')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Request a Church Event',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 30.0),
            // TextField for event name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
                labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.event, color: Colors.deepPurpleAccent),
              ),
            ),
            SizedBox(height: 20.0),
            // TextField for event description
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Event Description',
                labelStyle: TextStyle(color: Colors.deepPurpleAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon:
                    Icon(Icons.description, color: Colors.deepPurpleAccent),
              ),
            ),
            SizedBox(height: 20.0),
            // Submit Button
            ElevatedButton(
              onPressed: _submitEvent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Submit Request',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchChurchEventsPage extends StatefulWidget {
  const SearchChurchEventsPage({super.key});

  @override
  _SearchChurchEventsPageState createState() => _SearchChurchEventsPageState();
}

class _SearchChurchEventsPageState extends State<SearchChurchEventsPage> {
  List<dynamic> events = []; // To hold the fetched events
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    super.initState();
    fetchEvents(); // Fetch events when the page initializes
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.13/church_api/get_events.php')); // Adjust URL as needed
      if (response.statusCode == 200) {
        setState(() {
          events = jsonDecode(response.body); // Decode JSON response
          isLoading = false; // Stop loading
        });
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        isLoading = false; // Stop loading on error
      });
    }

    @override
    void initState() {
      super.initState();
      fetchEvents(); // Fetch events when the page initializes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Church Events'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while fetching data
            : events.isEmpty
                ? Center(
                    child: Text(
                        'No events found.')) // Message if no events are found
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(event['name']),
                          subtitle: Text(event['description']),
                          trailing: Text(
                              event['created_at']), // Display creation date
                        ),
                      );
                    },
                  ));
  }
}
