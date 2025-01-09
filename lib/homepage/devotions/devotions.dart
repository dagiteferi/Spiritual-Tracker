import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neh/Auth/user_model.dart';
import 'package:neh/constants/string_constants.dart';
import 'package:neh/helper/userFunctions.dart';
import 'package:neh/homepage/devotions/sermon/sermon.dart';
import 'package:neh/models/personModel.dart';
import 'package:flutter/services.dart';



class BibleVersesPage extends StatefulWidget {
  const BibleVersesPage({super.key});

  @override
  _BibleVersesPageState createState() => _BibleVersesPageState();
}

class _BibleVersesPageState extends State<BibleVersesPage> {
  List<String> bibleVerses = [
    "John 3:16 - For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.",
    "Psalm 23:1 - The Lord is my shepherd; I shall not want.",
    "Philippians 4:13 - I can do all things through Christ who strengthens me.",
    "Romans 8:28 - And we know that in all things God works for the good of those who love him.",
    "Proverbs 3:5-6 - Trust in the Lord with all your heart and lean not on your own understanding; in all your ways submit to him, and he will make your paths straight.",
    "Isaiah 40:31 - But those who hope in the Lord will renew their strength. They will soar on wings like eagles.",
    "Matthew 11:28 - Come to me, all you who are weary and burdened, and I will give you rest."
    "Nehemiah 2:20 - Then answered I them, and said unto them, The God of heaven, he will prosper us; therefore we his servants will arise and build: but ye have no portion, nor right, nor memorial, in Jerusalem.",
    "Jeremiah 29:11 - For I know the plans I have for you, declares the Lord, plans for welfare and not for evil, to give you a future and a hope",
    "Deuteronomy 31:6 - Be strong and courageous. Do not fear or be in dread of them, for it is the Lord your God who goes with you. He will not leave you or forsake you.",
   "Isaiah 41:10 - Fear not, for I am with you; be not dismayed, for I am your God; I will strengthen you, I will help you, I will uphold you with my righteous right hand.",
   "Psalm 34:8 - Oh, taste and see that the Lord is good! Blessed is the man who takes refuge in him!",
   "Lamentations 3:22-23 - The steadfast love of the Lord never ceases; his mercies never come to an end; they are new every morning; great is your faithfulness.",
  ];

  String todayVerse = "";
  List<String> filteredVerses = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setVerseOfTheDay();
    filteredVerses = bibleVerses; // Initially show all verses
    _searchController.addListener(() {
      _filterVerses(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void setVerseOfTheDay() {
    int dayOfYear =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    int verseIndex = dayOfYear % bibleVerses.length;
    setState(() {
      todayVerse = bibleVerses[verseIndex];
    });
  }

  void _filterVerses(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVerses = bibleVerses;
      } else {
        filteredVerses = bibleVerses
            .where((verse) =>
                verse.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Verse of the Day'),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Verse of the Day Section
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.asset(
                  'assets/bible.jpg',
                  height: 160.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 13.0),
              const Icon(Icons.book, size: 48, color: Colors.black),
              const SizedBox(height: 15.0),
              const Text(
                'Verse of the Day',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  todayVerse,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              const Divider(),
              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Bible Verses',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Display Filtered Verses
              Expanded(
                child: ListView.builder(
                  itemCount: filteredVerses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        filteredVerses[index],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sermon1DetailPage extends StatefulWidget {
  Sermon1DetailPage({super.key});

  @override
  State<Sermon1DetailPage> createState() => _Sermon1DetailPageState();
}

class _Sermon1DetailPageState extends State<Sermon1DetailPage> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('patternlight.mp3'));
      await player.resume();
    });

    print("naham");
  }

  @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sermons'),
        backgroundColor: const Color.fromARGB(255, 122, 115, 115),
      ),
      body: Container(
        color: const Color.fromARGB(255, 77, 68, 68),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap the content in a scrollable widget
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date
              Text(
                '📖 14 December 2024',
                style: TextStyle(
                  fontSize: 14.0,
                  color: const Color.fromARGB(255, 137, 132, 132),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                'God Will Answer',
                style: TextStyle(
                  fontSize: 22.0, // Larger title size for better emphasis
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Pastor: Yohannes Girma',
                style: TextStyle(
                  fontSize: 16.0, // Slightly larger for better legibility
                  color: const Color.fromARGB(255, 200, 186, 186),
                ),
              ),
              SizedBox(height: 20.0), // More spacing between sections
              Text(
                '“You will call on me and come and pray to me, and I will listen to you.”',
                style: TextStyle(
                  fontSize: 16.0, // Larger quote font size
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),

              // Bible verse reference
              Text(
                'Jeremiah 29:12',
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

              // New sermon text content with improved formatting
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
        'When Pastor Timothy wears his preacher collar while travelling, '
        'he often gets stopped by strangers. “Pray for me, please,” people in the '
        'airport say when they see the clerical band atop his simple dark suit. '
        'On a recent flight, a woman knelt by his seat when she noticed him, pleading: '
        '“Are you a pastor? Would you pray for me?” And Pastor Timothy prayed.'
        'A passage in Jeremiah sheds light on why we perceive that God hears and answers prayer'
        ' God cares! He assured His beloved but sinful, exiled people, “ ‘For I know the plans I have for you,’ '
        'declares the Lord, ‘plans to prosper you and not to harm you’ ” (Jeremiah 29:11). God anticipated a '
        'time when they would return to Him. “Then you will call on me and come and pray to me,” He said, “and '
        'I will listen to you. You will seek me and find me when you seek me with all your heart” (vv. 12-13).'
        'The prophet learned this and more about prayer while confined to prison. God assured him, “Call to me and '
        'I will answer you and tell you great and unsearchable things you do not know” (33:3).'
        'Jesus also urges us to pray. “Your Father knows what you need before you ask him,” '
        'He said (Matthew 6:8). So “ask,” “seek,” and “knock” in prayer (7:7). Every petition we make draws us '
        'closer to the one who answers. We don’t have to be a stranger to God in prayer. He knows us and wants to hear from us.'
        ' We can take our concerns to Him right now.',
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
            'How often do you pray? What will you say to God today?',
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
            'Your care and knowledge of me inspire my prayers, dear God. Thank You for answering.',
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
                'Seventy years is a long time, but the faithful prophet Daniel lived to see the promise of'
                ' God made through Jeremiah come true. Reading the book of Jeremiah’s prophecies, Daniel '
                'realized that the time for returning to Jerusalem was drawing close, and so he prayed that '
                'God would remember His promise and redeem His people (Daniel 9:1-3). God’s response was to '
                ' give Daniel a picture of what He planned to do with and through His people in the future.'
                'But God hadn’t forgotten His promise either. In the first year of his reign, the new Persian king, Cyrus, '
                'began returning the exiled Jews to their homeland (2 Chronicles 36:22-23). Daniel, who’d left for Babylon as '
                'a teenager (Daniel 1:6-7), was now an old man. He’d served wicked kings and not-so-wicked kings.'
                'Through it all, God protected him and the Jewish people, and the elderly prophet saw his prayer answered '
                'as God’s people returned home.',
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


class PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const PlayerWidget({
    required this.player,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState();
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    // Use initial values from player
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              key: const Key('play_button'),
              onPressed: _isPlaying ? null : _play,
              iconSize: 48.0,
              icon: const Icon(Icons.play_arrow),
              color: color,
            ),
            IconButton(
              key: const Key('pause_button'),
              onPressed: _isPlaying ? _pause : null,
              iconSize: 48.0,
              icon: const Icon(Icons.pause),
              color: color,
            ),
            IconButton(
              key: const Key('stop_button'),
              onPressed: _isPlaying || _isPaused ? _stop : null,
              iconSize: 48.0,
              icon: const Icon(Icons.stop),
              color: color,
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            final duration = _duration;
            if (duration == null) {
              return;
            }
            final position = value * duration.inMilliseconds;
            player.seek(Duration(milliseconds: position.round()));
          },
          value: (_position != null &&
                  _duration != null &&
                  _position!.inMilliseconds > 0 &&
                  _position!.inMilliseconds < _duration!.inMilliseconds)
              ? _position!.inMilliseconds / _duration!.inMilliseconds
              : 0.0,
        ),
        Text(
          _position != null
              ? '$_positionText / $_durationText'
              : _duration != null
                  ? _durationText
                  : '',
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }
}

Future<void> addEventToDatabase(Map<String, String> eventData) async {
  final url =
      Uri.parse('http://localhost/api.php'); // Update with your local API URL
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(eventData),
  );

  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    if (result['success']) {
      print("Event added successfully");
    } else {
      print("Failed to add event: ${result['message']}");
    }
  } else {
    print("Failed to connect to the server.");
  }
}

Future<List<Map<String, String>>> fetchEventsFromDatabase() async {
  final url =
      Uri.parse('http://localhost/api.php'); // Update with your local API URL
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> events = jsonDecode(response.body);
    return events.map((event) => Map<String, String>.from(event)).toList();
  } else {
    throw Exception("Failed to load events from database.");
  }
}
