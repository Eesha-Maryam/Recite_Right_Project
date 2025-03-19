import 'package:flutter/material.dart';

import 'header.dart';
import 'footer.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _hoveredTiles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: Header(scaffoldKey: _scaffoldKey),
      drawer: Header(scaffoldKey: _scaffoldKey).buildDrawer(context),
      endDrawer: const SettingsDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBannerSection(context),
            SizedBox(height: 10),
            _buildContentSection(context),
            SizedBox(height: 10),
            _buildFilterSection(context), // ✅ Added Filter Section above Tiles
            _buildTileSection(context),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Row(
              children: [
                Icon(Icons.search, color: charcoal),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'What do you want to read?',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                Icon(Icons.mic, color: charcoal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 900),
      decoration: BoxDecoration(
        color: const Color(0x8297B469),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildFeatureBox(
                title:
                    [
                      "Continue where you left off",
                      "Correct Mistakes",
                      "Progress Rate",
                      "Streaks",
                    ][index],
                content:
                    [
                      _buildResumeButton(),
                      _buildProgressBar(),
                      _buildProgressText(),
                      _buildStreaksText(),
                    ][index],
                alignLeft: index == 0,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20), // Moves the section downward
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtons(
                  isSelected: [true, false], // Example: First one selected

                  selectedColor: Colors.white,
                  color: Colors.black,
                  fillColor: oliveGreen,
                  onPressed: (index) {},
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text("Surah"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text("Juz"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Sort by: "), // Always visible
                    DropdownButton<String>(
                      value: "ASCENDING", // Default value
                      underline:
                          const SizedBox(), // Removes the default underline
                      onChanged: (value) {},
                      items:
                          ["ASCENDING", "DESCENDING"]
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20), // Only bottom margin added
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 900),
      decoration: BoxDecoration(
        border: Border.all(color: oliveGreen, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;
          return GridView.count(
            padding: EdgeInsets.zero, // Yeh line add karo
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 3,

            children: [
              _buildTile("Al-Fatihah", "(The Opening)"),
              _buildTile("Al-Baqarah", "(The Cow)"),
              _buildTile("Al-Imran", "(The Family of Imran)"),
              _buildTile("An-Nisa", "(The Women)"),
              _buildTile("Al-Maidah", "(The Table Spread)"),
              _buildTile("Al-An'am", "(The Cattle)"),
              _buildTile("Al-A'raf", "(The Heights)"),
              _buildTile("Al-Anfal", "(The Spoils of War)"),
              _buildTile("At-Tawbah", "(The Repentance)"),
              _buildTile("Yunus", "(Jonah)"),
              _buildTile("Hud", "(Hud)"),
              _buildTile("Yusuf", "(Joseph)"),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTile(String title, String subtitle) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredTiles.add(title)),
      onExit: (_) => setState(() => _hoveredTiles.remove(title)),
      child: InkWell(
        onTap: () => debugPrint("Tile Clicked: $title"),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color:
                _hoveredTiles.contains(title)
                    ? const Color(0x8297B469)
                    : Colors.white,
            border: Border.all(color: oliveGreen, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(subtitle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBox({
    required String title,
    required Widget content,
    bool alignLeft = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: alignLeft ? TextAlign.left : TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          content,
        ],
      ),
    );
  }

  Widget _buildResumeButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: oliveGreen,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width < 400 ? 6 : 10,
            horizontal: MediaQuery.of(context).size.width < 400 ? 12 : 20,
          ),
        ),
        child: Text(
          "Resume",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width < 400 ? 12 : 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: 4 / 24,
          color: oliveGreen,
          backgroundColor: Colors.grey.shade300,
        ),
        const SizedBox(height: 10),
        const Text("20/24"),
      ],
    );
  }

  Widget _buildProgressText() =>
      const Text("%", style: TextStyle(color: oliveGreen, fontSize: 30));
  Widget _buildStreaksText() =>
      const Text("Days", style: TextStyle(color: oliveGreen, fontSize: 30));
}
