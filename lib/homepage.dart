import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);
const Color creamWhite = Color(0xFFF8F5F0);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _hoveredTiles = {};

  // Screen size helpers
  bool get isMobile => MediaQuery.of(context).size.width < 600;
  bool get isTablet => MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 900;
  bool get isDesktop => MediaQuery.of(context).size.width >= 900;
  bool get isVerySmallMobile => MediaQuery.of(context).size.width <= 350;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      scaffoldKey: _scaffoldKey,
      showBottomBorder: false,
      background: creamWhite,
      extendBehind: true,
      body: Stack(
        children: [
          Container(color: creamWhite),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildBannerSection(context),
                const SizedBox(height: 8),
                _buildContentSection(context),
                const SizedBox(height: 8),
                _buildFilterSection(context),
                _buildTileSection(context),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isVerySmallMobile ? 12 : isMobile ? 16 : 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * (isVerySmallMobile ? 0.3 : isMobile ? 0.32 : 0.35),
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
            width: MediaQuery.of(context).size.width * (isVerySmallMobile ? 0.9 : isMobile ? 0.85 : 0.7),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: creamWhite,
              borderRadius: BorderRadius.circular(isVerySmallMobile ? 30 : isMobile ? 35 : 40),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.search, color: charcoal, size: isVerySmallMobile ? 18 : isMobile ? 20 : 22),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'What do you want to read?',
                      hintStyle: TextStyle(
                        fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: isVerySmallMobile ? 8 : 12),
                    ),
                  ),
                ),
                Icon(Icons.mic, color: charcoal, size: isVerySmallMobile ? 18 : isMobile ? 20 : 22),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildContentSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isVerySmallMobile ? 12 : isMobile ? 16 : 24,
        vertical: 8,
      ),
      padding: EdgeInsets.all(isVerySmallMobile ? 10 : isMobile ? 12 : 16),
      width: MediaQuery.of(context).size.width * (isVerySmallMobile ? 0.95 : isMobile ? 0.92 : 0.9),
      constraints: const BoxConstraints(maxWidth: 900),
      decoration: BoxDecoration(
        color: const Color(0x8297B469),
        borderRadius: BorderRadius.circular(isVerySmallMobile ? 12 : isMobile ? 14 : 16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine grid columns based on screen size
          int crossAxisCount;
          double childAspectRatio;
          
          if (isVerySmallMobile) {
            crossAxisCount = 2;
            childAspectRatio = 1.1;
          } else if (isMobile) {
            crossAxisCount = 2;
            childAspectRatio = 1.2;
          } else if (isTablet) {
            crossAxisCount = 4; // 4 blocks in row for tablet
            childAspectRatio = 1.0; // Adjusted ratio to fit content
          } else {
            crossAxisCount = 4;
            childAspectRatio = 1.3;
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: isVerySmallMobile ? 8 : isMobile ? 12 : 16,
              mainAxisSpacing: isVerySmallMobile ? 8 : isMobile ? 12 : 16,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return _buildFeatureBox(
                title: [
                  "Continue where you left off",
                  "Correct Mistakes",
                  "Progress Rate",
                  "Streaks",
                ][index],
                content: [
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
    return Container(
      width: MediaQuery.of(context).size.width * (isVerySmallMobile ? 0.95 : isMobile ? 0.92 : 0.88),
      constraints: const BoxConstraints(maxWidth: 900),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToggleButtons(
            isSelected: [true, false],
            selectedColor: creamWhite,
            color: Colors.black,
            fillColor: oliveGreen,
            onPressed: (index) {},
            constraints: BoxConstraints(
              minWidth: isVerySmallMobile ? 60 : isMobile ? 70 : 80,
              minHeight: isVerySmallMobile ? 32 : isMobile ? 34 : 36,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isVerySmallMobile ? 6 : isMobile ? 8 : 10,
                  vertical: 4,
                ),
                child: Text(
                  "Surah",
                  style: TextStyle(
                    fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isVerySmallMobile ? 6 : isMobile ? 8 : 10,
                  vertical: 4,
                ),
                child: Text(
                  "Juz",
                  style: TextStyle(
                    fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Sort by: ",
                style: TextStyle(
                  fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                ),
              ),
              DropdownButton<String>(
                value: "ASCENDING",
                underline: const SizedBox(),
                onChanged: (value) {},
                items: ["ASCENDING", "DESCENDING"].map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTileSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(isVerySmallMobile ? 8 : isMobile ? 10 : 12),
      width: MediaQuery.of(context).size.width * (isVerySmallMobile ? 0.95 : isMobile ? 0.92 : 0.88),
      constraints: const BoxConstraints(maxWidth: 900),
      decoration: BoxDecoration(
        color: creamWhite,
        border: Border.all(color: oliveGreen, width: isTablet ? 1.25 : 1.5),
        borderRadius: BorderRadius.circular(isVerySmallMobile ? 10 : isMobile ? 12 : 14), // Reduced radius for tablet
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth < 500) {
            crossAxisCount = 2;
          } else if (isTablet) {
            crossAxisCount = 3; // Changed to 3 for tablet
          } else {
            crossAxisCount = 3;
          }

          return GridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isVerySmallMobile ? 6 : isMobile ? 8 : 10,
            mainAxisSpacing: isVerySmallMobile ? 6 : isMobile ? 8 : 10,
            childAspectRatio: isTablet ? 2.8 : isVerySmallMobile ? 2.5 : 3,
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
        borderRadius: BorderRadius.circular(isVerySmallMobile ? 8 : isMobile ? 10 : 12), // Reduced radius
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _hoveredTiles.contains(title) ? oliveGreen.withOpacity(0.12) : creamWhite,
            border: Border.all(color: oliveGreen, width: isTablet ? 1.25 : 1.5),
            borderRadius: BorderRadius.circular(isVerySmallMobile ? 8 : isMobile ? 10 : 12), // Reduced radius
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isVerySmallMobile ? 10 : isMobile ? 12 : 14,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
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
      padding: EdgeInsets.all(isVerySmallMobile ? 8 : isMobile ? 10 : isTablet ? 10 : 12),
      decoration: BoxDecoration(
        color: creamWhite,
        borderRadius: BorderRadius.circular(isVerySmallMobile ? 10 : isMobile ? 12 : isTablet ? 12 : 14),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: alignLeft ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : isTablet ? 14 : 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          // Special handling for tablet content sizing
          if (isTablet) 
            SizedBox(
              height: 60, // Fixed height for tablet content
              child: content,
            )
          else
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
            borderRadius: BorderRadius.circular(isVerySmallMobile ? 18 : isMobile ? 20 : 22), // Reduced radius
          ),
          backgroundColor: oliveGreen,
          padding: EdgeInsets.symmetric(
            vertical: isVerySmallMobile ? 4 : isMobile ? 6 : 8,
            horizontal: isVerySmallMobile ? 10 : isMobile ? 12 : 16,
          ),
        ),
        child: Text(
          "Resume",
          style: TextStyle(
            color: creamWhite,
            fontSize: isVerySmallMobile ? 10 : isMobile ? 12 : 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: 4/24,
          color: oliveGreen,
          backgroundColor: Colors.grey.shade300,
        ),
        const SizedBox(height: 6),
        Text(
          "20/24",
          style: TextStyle(fontSize: isVerySmallMobile ? 12 : isMobile ? 14 : 16),
        ),
      ],
    );
  }

  Widget _buildProgressText() => Text(
    "%",
    style: TextStyle(
      color: oliveGreen,
      fontSize: isVerySmallMobile ? 20 : isMobile ? 22 : 24, // Reduced size for tablet
    ),
  );

  Widget _buildStreaksText() => Text(
    "Days",
    style: TextStyle(
      color: oliveGreen,
      fontSize: isVerySmallMobile ? 20 : isMobile ? 22 : 24, // Reduced size for tablet
    ),
  );
}
