import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:neh/homepage/devotions/devotions.dart';
import 'package:neh/homepage/devotions/sermon/sermon3/sermon3.dart';
//import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
//import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class SermonListPage extends StatefulWidget {
  SermonListPage({super.key});

  @override
  State<SermonListPage> createState() => _SermonListPageState();
}

class _SermonListPageState extends State<SermonListPage> {
  // Method to open the YouTube link
  void _launchYouTubeLink() async {
    const url =
        'https://www.youtube.com/@InTouchMinistries'; // Replace with your desired YouTube link
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSermonWidget(BuildContext context, int sermonNumber) {
    final sermonDetails = [
      {
        'title': 'God Will Answer',
        'pastor': 'Yohannes Girma',
        'date': '14 December 2024',
        'image': 'assets/b.jpg',
      },
      {
        'title': 'Faithful Servant',
        'pastor': 'Samuel Tesfaye',
        'date': '14 December 2024',
        'image': 'assets/h.jpg',
      },
      {
        'title': 'The Light Of Christ',
        'pastor': 'Abraham Yohannes',
        'date': '14 December 2024',
        'image': 'assets/e_1.jpg',
      },
      {
        'title': 'Hope in Christ',
        'pastor': 'Lydia Tsegaye',
        'date': '14 December 2024',
        'image': 'assets/a.jpg',
      },
      {
        'title': 'Eternal Joy',
        'pastor': 'Daniel Mekonnen',
        'date': '14 December 2024',
        'image': 'assets/c.jpg',
      },
    ];

    final details = sermonDetails[sermonNumber - 1];

    return SizedBox(
      width: double.infinity,
      height: 95,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: () {
            if (sermonNumber == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sermon1DetailPage()),
              );
            } else if (sermonNumber == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sermon2DetailPage()),
              );
            } else if (sermonNumber == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sermon3DetailPage()),
              );
            } else if (sermonNumber == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sermon4DetailPage()),
              );
            } else if (sermonNumber == 5) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Sermon5DetailPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${details['title']} tapped')),
              );
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 48, 44, 44),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: Center(
                        child: Text(
                          details['title']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.7),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          details['pastor']!,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 1.0,
                left: 2.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    width: 65.0,
                    height: 85.0,
                    child: Image.asset(
                      details['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1.0,
                left: 70.0,
                child: Text(
                  '📖 ${details['date']}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: const Color.fromARGB(255, 170, 166, 166),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sermons')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _buildSermonWidget(context, index + 1),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _launchYouTubeLink,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
              child: Text('+ Load More'),
            ),
          ],
        ),
      ),
    );
  }
}

// Sermon1DetailPage remains the same

class Sermon2DetailPage extends StatefulWidget {
  Sermon2DetailPage({super.key});

  @override
  State<Sermon2DetailPage> createState() => _Sermon2DetailPageState();
}

class _Sermon2DetailPageState extends State<Sermon2DetailPage> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('faith.mp3'));
      await player.resume();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faithful Servant'),
        backgroundColor: const Color.fromARGB(255, 122, 115, 115),
      ),
      body: Container(
        color: const Color.fromARGB(255, 77, 68, 68),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📖 14 December 2024',
                style: TextStyle(
                  fontSize: 14.0,
                  color: const Color.fromARGB(255, 137, 132, 132),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'Faithful Servant',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Pastor: Samuel Tesfaye',
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 200, 186, 186),
                ),
              ),
              SizedBox(height: 20.0), // More spacing between sections
              Text(
                '“He Who Promised Is Faithful. Let us hold unswervingly to the hope we profess, for he who promised is faithful.”',
                style: TextStyle(
                  fontSize: 16.0, // Larger quote font size
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),

              // Bible verse reference
              Text(
                'Hebrews 10:23',
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 217, 208, 208),
                ),
              ),

              // Divider for space and line between texts
              Divider(
                color: Colors.white,
                thickness: 1.0,
                height: 30.0,
              ),

              _buildSermonContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSermonContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      PlayerWidget(player: player),
      Text(
        'My first Christmas living in England felt like a failure—not least because the special meal I had enjoyed each year with my family of origin was a flop. And I felt keenly the distance separating me from my American loved ones. But comforting words from my new husband, and my parents over the phone, helped to ease my pain. Also, Nicholas and I asked God to help us create a meaningful holiday that we could enjoy with others.'
        'We wanted to unite our traditions and share the wonder of God becoming a baby and living as one of us. We desired to celebrate Jesus, the “man of suffering” who was “familiar with pain” (Isaiah 53:3)—He who had Himself experienced separation and loss.'
        'This passage from the prophet Isaiah was given to God’s people to prepare them for the Babylonian captivity, to deepen their hope and faith in God. But the prophecy is also fulfilled through the birth, life and death of Jesus: “Surely he took up our pain and bore our suffering . . . . The punishment that brought us peace was on him, and by his wounds we are healed” (vv. 4, 5).'
        '  Jesus knew sorrow on this earth, but through His death He has brought us forgiveness and freedom. Through His wounds we find peace and healing—even when we face Christmas apart from loved ones.'
        'My first Christmas living in England felt like a failure—not least because the special meal I had enjoyed each year with my family of origin was a flop. And I felt keenly the distance separating me from my American loved ones. But comforting words from my new husband, and my parents over the phone, helped to ease my pain. Also, Nicholas and I asked God to help us create a meaningful holiday that we could enjoy with others'
        'My first Christmas living in England felt like a failure—not least because the special meal I had enjoyed each year with my family of origin was a flop. And I felt keenly the distance separating me from my American loved ones. But comforting words from my new husband, and my parents over the phone, helped to ease my pain. Also, Nicholas and I asked God to help us create a meaningful holiday that we could enjoy with others',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          height: 1.6,
        ),
      ),
      Divider(
        color: Colors.white,
        thickness: 1.0,
        height: 30.0,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 12.0), // Add spacing below the text
          child: Text(
            'Reflect And Pray',
            style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
              color: const Color.fromARGB(255, 255, 255, 255),
              height: 1.6, // Adds line height for better readability
            ),
          ),
        ),

        // Bible verse reference with improved spacing
        Padding(
          padding:
              const EdgeInsets.only(bottom: 12.0), // Add spacing below the text
          child: Text(
            'In what ways can you serve your church family? When will you start?',
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              color: const Color.fromARGB(255, 199, 182, 182),
              height: 1.6, // Adds line height for better readability
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 12.0), // Add spacing below the text
          child: Text(
            'Dear God, You’ve done so much for me and deserve my love. Please empower me and show me how to serve others where I am.',
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              color: const Color.fromARGB(255, 217, 208, 208),
              height: 1.6, // Adds line height for better readability
            ),
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1.0,
          height: 30.0,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Adding padding to the "Insight" text for spacing
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0), // Spacing below "Insight"
              child: Text(
                'Insight',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  height: 1.6,
                ),
              ),
            ),

            // Paragraph text with existing padding
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 20.0), // Spacing below the paragraph
              child: Text(
                'In Matthew 20, Jesus used two words to describe how those who believe in Him are'
                ' to relate to each other: diakonos, translated “servant” (v. 26) and doulos, '
                ' translated “slave” (v. 27). Christ turns our common understanding of greatness on '
                ' its head. He teaches that instead of the greater giving orders to the lesser, the '
                ' greater person is the one who serves others. In the upside-down kingdom of God'
                ' Jesus tells His disciples that to be “great” (v. 26), they must look out for '
                'the needs of others: “Whoever wants to be a leader among you must be your servant, and whoever'
                ' wants to be first among you must become your slave” (vv. 26-27 NLT).',
                style: TextStyle(
                  fontSize: 16.0, // Adjusted font size for readability
                  fontStyle: FontStyle.normal,
                  color: const Color.fromARGB(255, 255, 250, 250),
                  height: 1.8, // Improved line height for better readability
                  letterSpacing: 0.5, // Added letter spacing for text clarity
                ),
                textAlign: TextAlign.justify, // Balanced text alignment
              ),
            ),
          ],
        )
      ])
    ]);
  }
}
