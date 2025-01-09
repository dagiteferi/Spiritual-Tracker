import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:neh/homepage/churchcalander.dart';
import 'package:neh/homepage/devotions/devotions.dart';
import 'package:neh/homepage/devotions/sermon/sermon.dart';
import 'package:neh/homepage/prayer%20request/prayer%20request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'searchvoice.dart'; // Import your voice search page


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // Sample data list for search (you can customize this with more data)
  List<HoverWidgetData> allItems = [
    HoverWidgetData(
      title: 'Bible Verses',
    //  icon: Icons.book,
      image: 'assets/download.jpg',
      description: 'Read Bible verses daily and stay spiritually uplifted.',
      
    ),
    HoverWidgetData(
      title: 'Prayer Requests',
    //  icon: Icons.request_page,
      image: 'assets/papic.jpg',
      description: 'Submit prayer requests and pray with the community.',
      
    ),
    HoverWidgetData(
      title: 'Church Calendar',
     // icon: Icons.calendar_today,
      image: 'assets/cal.jpeg',
      description: 'Stay updated with church events and activities.',
    ),
    HoverWidgetData(
      title: 'Sermons',
     // icon: Icons.headset,
      image: 'assets/pa.jpg',
      description: 'Listen to inspiring sermons from church leaders.',
    ),
  ];

  List<HoverWidgetData> filteredItems = [];

  @override
  void initState() {
    super.initState();
    // Initially, display all items
    filteredItems = allItems;
  }

  void _filterSearchResults(String query) {
    List<HoverWidgetData> dummySearchList = [];
    dummySearchList.addAll(allItems);
    if (query.isNotEmpty) {
      List<HoverWidgetData> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.description.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredItems = dummyListData;
      });
    } else {
      setState(() {
        filteredItems = allItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(hintText: "Search..."),
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                autofocus: true,
                onChanged: _filterSearchResults,
              )
            : Text('Spiritual Tracker'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _searchController.clear();
                }
                _isSearching = !_isSearching;
                filteredItems = allItems; // Reset the filtered items
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/wel.jpg'),
                  ),
                  SizedBox(height: 10.0),
                  Text('Welcome,', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ],
             
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountPage(),
                       ),
                  );
                },
              ),
                // Handle navigation to Account Page
              
            
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact Us'),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsPage()),
                  );
                },
              ),
                // Handle navigation to Contact Us Page
              
        
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Share Feedback'),
              onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareFeedbackPage()),
                  );
                // Handle navigation to Share Feedback Page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsPage()),
                  );
                // Handle navigation to About Us Page
              },
            ),
            // Church Calendar Navigation
              ListTile(
              leading: Icon(Icons.info),
              title: Text('SearchVoice'),
              onTap: () {
  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchVoice()),
                  );
                // Handle navigation to About Us Page
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Church Calendar'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ChurchCalendarPage()),
                );
              },
            ),
          ],
        ),
      ),
        
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            var item = filteredItems[index];
            return HoverWidget(
              title: item.title,
             // icon: item.icon,
              image: item.image,
              description: item.description,
               onTap: () {
        // Navigate to the respective page
        if (item.title == 'Bible Verses') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BibleVersesPage()),
          );
           } else if (item.title == 'Prayer Requests') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PrayerRequestPage()),
          );
        } else if (item.title == 'Church Calendar') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChurchCalendarPage()),
          );
        } else if (item.title == 'Sermons') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SermonListPage()),
          );
        }
      },
            );
          },
        ),
      ),
    );
  }
}
class HoverWidgetData {
  final String title;
  final String image;
  final String description;

  HoverWidgetData({
    required this.title,
    required this.image,
    required this.description,
  });
}
class HoverWidget extends StatefulWidget {
  final String title;
  final String image;
  final String description;
   final VoidCallback onTap; // Add this

  const HoverWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
      required this.onTap, // Add this
  }) : super(key: key);

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
        onTap: widget.onTap, // Handle tap here
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Background Image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
          ),
          

          // Hover overlay with text
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Title
              if (!_isHovered)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
        )
    );
  }
}
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Registration')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Section
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(
                          'assets/user_profile.jpg'), // Add your image
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // Form Section
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // Phone Number Field
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // Sign In Button
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareFeedbackPage extends StatefulWidget {
  const ShareFeedbackPage({super.key});

  @override
  State<ShareFeedbackPage> createState() => _ShareFeedbackPageState();
}

class _ShareFeedbackPageState extends State<ShareFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  String _selectedFeedbackType = 'General';

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your feedback!')),
      );
      // Clear the feedback form
      _feedbackController.clear();
      setState(() {
        _selectedFeedbackType = 'General';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Share Feedback'),
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
                      'We Value Your Feedback',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Feedback Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Feedback Type Dropdown
                        const Text(
                          'Select Feedback Type:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedFeedbackType,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                          ),
                          items: ['General', 'Suggestion', 'Issue', 'Praise']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFeedbackType = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Feedback Text Field
                        const Text(
                          'Your Feedback:',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _feedbackController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Write your feedback here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Feedback cannot be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Submit Button
                        Center(
                          child: ElevatedButton(
                            onPressed: _submitFeedback,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 24.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: const Text(
                              'Submit Feedback',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Contact Information
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Need Assistance?',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'You can reach us at ',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              TextSpan(
                                text: 'mimneh@gmail.com',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch('mailto:mimneh@gmail.com');
                                  },
                              ),
                              TextSpan(
                                text: ' or call ',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              TextSpan(
                                text: '+251 901723123',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch('tel:+251901723123');
                                  },
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ])));
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Us Header
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Text(
                'We\'d Love to Hear From You!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Contact Form
            const Text(
              'Get in Touch:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ContactForm(),
            const SizedBox(height: 30),

            // Social Media Links
            const Text(
              'Follow Us:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            const SizedBox(height: 20),

            // Contact Info
            const Text(
              'Alternatively, reach us directly:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: mimneh@gmail.com.com',
              style: TextStyle(fontSize: 14.0, color: Colors.blue),
            ),
            const Text(
              'Phone: +251 901723123',
              style: TextStyle(fontSize: 14.0, color: Colors.blue),
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

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your message has been sent!')),
      );
      // You can also implement sending the message to a backend or email service here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Your Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Message Field
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Your Message',
              prefixIcon: Icon(Icons.message),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Message cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Submit Button
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Send Message',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // About Us Header with image and text
            Container(
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/about_us_header.jpg'), // Add a suitable image here
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  'Welcome to Spiritual Tracker!',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 192, 177, 177),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10.0)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Section
            const Text(
              'Our Mission',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'At Spiritual Tracker, we aim to help individuals grow in their faith journey. Through our platform, '
              'we provide tools, resources, and content to help nurture spiritual growth and connect with others '
              'in the community. Whether you\'re looking for daily devotionals, prayer requests, or inspiration, '
              'we are here to support you.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),

            // Team Section
            const Text(
              'Meet Our Team',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildTeamMember(
                  'assets/nehm.jpg', // Replace with actual image paths
                  'Nehmya Biruk',
                  'Founder',
                ),
                _buildTeamMember(
                  'assets/abeni.jpg',
                  'Abenezer Ayele',
                  'Community Manager',
                ),
                _buildTeamMember(
                  'assets/henok.jpg',
                  'Henok Tesfaye',
                  'Content Creator',
                ),
                _buildTeamMember(
                  'assets/dagim.jpg',
                  'Dagmawi Teferi',
                  'Excuetive Manager',
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Vision Section
            const Text(
              'Our Vision',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We envision a world where individuals are equipped and empowered to grow spiritually in all aspects of their lives. '
              'Our vision is to build a community that is committed to prayer, devotion, and helping each other navigate their faith journey.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),

            // Footer with social media links
            const Text(
              'Follow Us:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String imagePath, String name, String role) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40.0,
          backgroundImage: AssetImage(imagePath),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          role,
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
      ],
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
