import 'package:flutter/material.dart';
import 'package:recite_right_project/UserProfile.dart';

const Color charcoal = Color(0xFF333333);
const Color oliveGreen = Color(0xFF97B469);

class Header extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Header({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        'RECITE RIGHT',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.black),
          onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ],
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader('RECITE RIGHT', context),
          _buildSubHeading('MENU'),
          _buildSeparator(),
          _buildMenuSection('Home', Icons.home, () {}),
          _buildSeparator(),
          _buildMenuSection('Dashboard', Icons.dashboard, () {}),
          _buildSeparator(),
          _buildMenuSection('Quran', Icons.menu_book, () {}),
          _buildSeparator(),
          _buildMenuSection('Memorization Test', Icons.memory, () {}),
          _buildSeparator(),
          _buildMenuSection('Mutashibihat', Icons.compare_arrows, () {}),
          _buildSeparator(),
          _buildMenuSection('Feedback', Icons.feedback, () {}),
          _buildSeparator(),
          _buildMenuSection('Help', Icons.help, () {}),
          _buildSeparator(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(String title, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: charcoal,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 179, 171, 171),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() => const Divider(
    indent: 16,
    endIndent: 16,
    height: 16,
    thickness: 1,
    color: Colors.black,
  );

  Widget _buildSubHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, IconData icon, Function()? onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // Added scroll functionality
        child: Column(
          children: [
            _buildDrawerHeader('SETTINGS', context),
            _buildMenuSection('THEME', Icons.brightness_6, null),
            _buildToggleWithDescription(
              "Choose Light or Dark modes using the theme selector. Your preference applies instantly and saves automatically.",
              true,
              "Light Mode",
              "Dark Mode",
            ),
            _buildSeparator(),
            _buildMenuSection('QURAN FONT', Icons.font_download, null),
            _buildQuranFontDisplay(),
            _buildFontAdjuster(),
            _buildSeparator(),
            _buildMenuSection('VOICE CONTROL', Icons.mic, null),
            _buildToggleWithDescription(
              "Use the toggle above to switch between Voice and Text input modes. Your preference will be saved for your next visit.",
              false,
              "ON",
              "OFF",
            ),
            _buildSeparator(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("RESET SETTINGS"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(String title, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: charcoal,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 179, 171, 171),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleWithDescription(
    String description,
    bool isTheme,
    String option1,
    String option2,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 23),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(22),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment:
                    isTheme ? Alignment.centerLeft : Alignment.centerRight,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    isTheme ? option1 : option2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child:
                              isTheme
                                  ? const SizedBox()
                                  : Text(
                                    option1,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child:
                              isTheme
                                  ? Text(
                                    option2,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                  : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            description,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() => const Divider(
    indent: 16,
    endIndent: 16,
    height: 16,
    thickness: 1,
    color: Colors.black,
  );

  Widget _buildMenuSection(String title, IconData icon, Function()? onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildQuranFontDisplay() {
    return Container(
      height: 80,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: const Center(
        child: Text(
          "بِسْمِ ٱللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildFontAdjuster() {
    int fontSize = 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Font Size", textAlign: TextAlign.left),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.grey[300],
                child: Text("$fontSize"),
              ),
              IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
