import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class SearchVoice extends StatefulWidget {
  @override
  _SearchVoiceState createState() => _SearchVoiceState();
}

class _SearchVoiceState extends State<SearchVoice> {
  late stt.SpeechToText _speech;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;
  String _text = "Press the button and start speaking";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onError: (error) => print('Error: $error'),
        onStatus: (status) => print('Status: $status'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          String recognizedText = result.recognizedWords.trim().toLowerCase();
          setState(() {
            _text = recognizedText;
          });
          print("Recognized Text: $recognizedText"); // Debugging
          _respondToInput(recognizedText);
        });
      } else {
        print("Speech recognition not available.");
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _respondToInput(String input) async {
    if (input.contains("hello")) {
      await _speak("Hello! How can I assist you?");
    } 
    if (input.contains("how are you")) {
      await _speak("I'm just a voice assistant, but call me Nehmya!");
    } else if (input.contains("service")) {
      await _speak(
          "I can provide advice for your life, Bible verses, spiritual books, and information about gospel singers and preachers.");
    } else if (input.contains("advice")) {
      await _speak(
          "Minister out of your prayer life and your personal walk with God. Personal holiness, private devotion, and closet prayer are key for effective ministry. Bounds said it best, “Men are looking for better methods, but God is looking for better men.” Personality, charisma, and charm will only take a man so far. Personal holiness, private devotion, and closet prayer are the prerequisites for effective ministry. The authenticity of one’s ministry is measured by his personal desire to pursue the presence of God in those private moments of life.");
    } else if (input.contains("verse")) {
      await _speak(
          "Here is a verse: First Peter 5:7 - Cast all your anxiety on him because he cares for you. here is another verse Second Timothy 1:7 - For God has not given us a spirit of fear, but of power and of love and of a sound mind. here is another verse Philippians 4:13 - I can do all things through Christ who strengthens me. here is another verse John 3:16 - For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life. here is another verse Romans 8:28 - And we know that in all things God works for the good of those who love him, who have been called according to his purpose. here is another verse Isaiah 41:10 - So do not fear, for I am with you; do not be dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand.");
    } else if (input.contains("singers")) {
      await _speak(
          "Some gospel singers are one Lealem Tilahun, two Ephrem Alemu, three Tesfaye Chala, four Bereket Tesfaye, five Kalkidan Tilahun Lily, and many more.if you want to listen therir gospel song you cann listen in youtube");
    } else if (input.contains("preachers")) {
      await _speak(
          "Some gospel preachers are one Apostle Zelalem Getachew, two Pastor Yared Tilahun, three Pastor Abraham Teklemariam,four pastor dawit molalign five pastor yonas tsegaye six apostile tamrat tarekegn and others. if you want listen to their preachers you can listen to them on youtube");
    } else if (input.contains("books")) {
      await _speak(
          "Here are some spiritual books: one The Practice of the Presence of God by Brother Lawrence, two Falling Upward by Richard Rohr, three The Life You've Always Wanted: Spiritual Disciplines for Ordinary People by john ortberg The Life of the Beloved: Spiritual Living in a Secular World by henry and others. if you want to read the book in google by searching their name you can get them and you can get other spritual books too");
    } else {
      await _speak("ok");
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  Future<void> _stopSpeaking() async {
    await _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Voice"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_text),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? "Listening..." : "Start Listening"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _stopSpeaking,
              child: Text("Stop Talking"),
            ),
          ],
        ),
      ),
    );
  }
}
