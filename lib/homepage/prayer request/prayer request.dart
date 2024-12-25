import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final request = _requestController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrayerRequestDetailsPage(
            name: name,
            request: request,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Request'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Section
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
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

            // Prayer Request Form
            const Text(
              'Submit Your Prayer Request:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name Field
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

                  // Prayer Request Field
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

                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitRequest,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.blueAccent,
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

            // Footer Section with Social Media Links
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

class PrayerRequestDetailsPage extends StatelessWidget {
  final String name;
  final String request;

  const PrayerRequestDetailsPage({
    super.key,
    required this.name,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Request Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Thank you for your submission!',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Name: ${name.isEmpty ? 'Anonymous' : name}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Prayer Request:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              request,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Back to Prayer Request'),
            ),
          ],
        ),
      ),
    );
  }
}
