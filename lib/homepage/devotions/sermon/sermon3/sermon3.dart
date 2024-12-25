import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neh/homepage/devotions/devotions.dart';

class Sermon3DetailPage extends StatefulWidget {
  Sermon3DetailPage({super.key});

  @override
  State<Sermon3DetailPage> createState() => _Sermon3DetailPageState();
}

class _Sermon3DetailPageState extends State<Sermon3DetailPage> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('joyforeternity.mp3'));
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
        title: Text('Walk in Light'),
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
                'The Light Of Christ',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Pastor: Abraham Yohannes',
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 200, 186, 186),
                ),
              ),
              SizedBox(height: 20.0), // More spacing between sections
              Text(
                '“Then Jesus said unto them, Yet a little while is the light with you. Walk while ye have the light, lest darkness come upon you: for he that walketh in darkness knoweth not whither he goeth.”',
                style: TextStyle(
                  fontSize: 16.0, // Larger quote font size
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),

              // Bible verse reference
              Text(
                'John 12 : 35',
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

              SizedBox(height: 20.0),
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
        'My husband and I have always enjoyed attending the Christmas '
        'Eve service at our church. In the early years of our marriage '
        'we had a special tradition of bundling up in warm clothing after '
        'the service to hike up a nearby hill where 350 glowing lights were '
        'strung from tall poles in the shape of a star. There—often in the snow—we’d whisper our '
        'reflections on Jesus’ miraculous birth while we gazed out over the city. Meanwhile, many people in the town were looking up at the bright, string-light star from the valley below. '
        'That star is a reminder of the birth of our Saviour. The Bible tells of magi “from the east” who arrived in Jerusalem seeking “the one who [had] been born king of the Jews” (Matthew 2:1-2). '
        'They’d been watching the skies and had seen the star “when it rose” (v. 2). Their journey took them onward from Jerusalem to Bethlehem, the star going “ahead of them until it stopped over the place where the child was” (v. 9). '
        'There, they “bowed down and worshipped him” (v. 11). '
        'Christ is the source of light in our lives both figuratively (as the one who guides us) and literally as the one who created the sun, moon and stars in the sky (Colossians 1:15-16). '
        'Like the magi who “were overjoyed” when they saw His star (Matthew 2:10), our greatest delight is in knowing Him as the Saviour who came down from the heavens to dwell among us. '
        '“We have seen his glory” (John 1:14)!',
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
            'How has Jesus brought light to your life? With whom might you share that today?',
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
            'Thank You, Jesus, for being the light of my life.',
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
                'We see an interesting connection between the genealogy in Matthew 1 and some key characters in Matthew 2. '
                'In the genealogy, several gentiles are listed among the ancestors of Jesus, including Rahab and Ruth (v. 5). '
                'Rahab heard of the miracles God performed on behalf of the Israelites and decided she’d rather join God’s people '
                'than be destroyed along with her pagan city of Jericho (Joshua 2). '
                'Ruth left her country of Moab to follow her mother-in-law Naomi’s God—the one true God (Ruth 1:16-17) and became '
                'King David’s great-grandmother. '
                'In Matthew 2, the magi from the east came to search for “the one who has been born king of the Jews” (v. 2). '
                'They too were gentiles pursuing the one true God. '
                'John the apostle wrote: “[Jesus] is the atoning sacrifice for our sins, and not only for ours but also for the sins of the whole world” (1 John 2:2).',
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

class Sermon4DetailPage extends StatefulWidget {
  Sermon4DetailPage({super.key});

  @override
  State<Sermon4DetailPage> createState() => _Sermon4DetailPageState();
}

class _Sermon4DetailPageState extends State<Sermon4DetailPage> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('forgive.mp3'));
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
        title: Text('Hope in Christ'),
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
                'Hope in Christ',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Pastor: Lydia Tsegaye',
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 200, 186, 186),
                ),
              ),
              SizedBox(height: 20.0), // More spacing between sections
              Text(
                '“Now the God of hope fill you with all joy and peace in believing, that ye may abound in hope, through the power of the Holy Ghost.”',
                style: TextStyle(
                  fontSize: 16.0, // Larger quote font size
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),

              // Bible verse reference
              Text(
                'Romans 15 : 13',
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

              SizedBox(height: 20.0),
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
        'Heather faces many challenges, including living with a debilitating chronic illness and the effects of'
        'breaking her coccyx after a fall. This means that she cannot work and now has to depend on Universal Credit.'
        'She has found encouragement from this Old Testament verse: “The Lord will fight for you; you need only to be still” . '
        '(Exodus 14:14). She realised, “I had to let God into this and not do [things] on my own.” Heather sees “God’s presence in little wins”, '
        'such as moving through the benefits system with surprising ease. But some days she feels discouraged, and so she has had the verse tattooed on her ankle.'
        '“I always see it and remember what God has done in that day,” she says.'
        'Whatever we face, we too can trust that the Lord fights on our behalf. We believe that we can be still as we put our trust in Him.',
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
            'How might these ancient words from Exodus apply to you today? How can you exercise trust in God when you face challenges?',
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
            'Loving God, thank You that You can provide help for me in ways that I might never imagine. You are a good and faithful God.',
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
                'After Pharaoh set the Jews free from slavery (Ex. 12:28-33), he immediately had a'
                ' change of heart and summoned his elite army to recapture them (14:5-9). Although God had overwhelmingly demonstrated'
                ' His great power through the 10 plagues (Ex. 7–11), the Jews chose not to trust in Him. Terrified, they accused Moses '
                'of deceiving them and leading them into the wilderness to die (14:11-12). But Moses encouraged them not to be afraid and to be still and trust the Lord'
                ' (vv. 13-14). God was faithful and saved them from Pharaoh’s army (vv. 21-23), and He continued to provide for them during their 40 years in the wilderness.',
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

class Sermon5DetailPage extends StatefulWidget {
  Sermon5DetailPage({super.key});

  @override
  State<Sermon5DetailPage> createState() => _Sermon5DetailPageState();
}

class _Sermon5DetailPageState extends State<Sermon5DetailPage> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource('joyforeternity.mp3'));
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
        title: Text('Eternal Joy'),
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
                'Eternal Joy',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Pastor: Daniel Mekonnen',
                style: TextStyle(
                  fontSize: 16.0,
                  color: const Color.fromARGB(255, 200, 186, 186),
                ),
              ),
              SizedBox(height: 20.0), // More spacing between sections
              Text(
                '“Thou wilt shew me the path of life: in thy presence [is] fulness of joy; at thy right hand [there are] pleasures for evermore.”',
                style: TextStyle(
                  fontSize: 16.0, // Larger quote font size
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),

              // Bible verse reference
              Text(
                'Psalms 16 : 11',
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
              SizedBox(height: 20.0),
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
        'While I was on an outreach during a short-term mission trip to Peru, a young man asked me for money. For security'
        'reasons, my team had been instructed not to give out money, so how could I help him? Then'
        ' I recalled the response of the apostles Peter and John to the lame man in Acts 3. I explained to him that I couldn’t'
        ' give him money, but I could share the good news of God’s love with him. When he said that he was an orphan,'
        ' I told him that God wants to be his Father. That brought him to tears. I connected him with a member of our host'
        ' church for follow up.'
        'Sometimes our words can feel so insufficient, but the Holy Spirit can empower us as we share Jesus with others.'
        'When Peter and John came across the man by the temple courts, they knew that sharing Christ was the greatest gift ever. '
        '“Then Peter said, ‘Silver or gold I do not have, but what I do have I give you. In the name of Jesus Christ of Nazareth, walk’ ”'
        ' (v. 6). The man received salvation and healing that day. God continues to use us to draw the lost to Him.'
        'As we search for the perfect gifts to give this Christmas, let’s remember that the true gift is knowing Jesus and '
        'the gift of eternal salvation He offers. Let’s continue to seek to be used by God to lead people to the Saviour.',
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
            'Who can you pray for this Christmas? Who can you share Christ with?',
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
            'Heavenly Father, thank You for the gift of Jesus.',
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
                'The book of Acts begins just before Jesus’ ascension and then proceeds to chronicle the acts of the'
                ' apostles and the early church. After Christ ascended on the Mount of Olives (1:9-12), the disciples '
                'returned to Jerusalem and appointed Matthias to replace Judas (vv. 12-26). In chapter 2, we learn it was on the day of '
                'Pentecost, when Jews gathered from many nations to celebrate the festival. The disciples and other believers '
                'were gathered in a house when they heard a sound like roaring wind and what looked like “tongues of fire” '
                '(v. 3) separated and settled on each of them, filling them with the Holy Spirit (vv. 1-4). The believers'
                ' immediately began speaking in other languages. The racket brought the crowds running. At once,'
                ' Peter shouted to address the crowd and preached the gospel. Afterward, three thousand people believed '
                'and were baptized (v. 41).',
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
