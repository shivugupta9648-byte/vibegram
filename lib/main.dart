import 'package:flutter/material.dart';

void main() {
  runApp(const VibeGramApp());
}

class VibeGramApp extends StatefulWidget {
  const VibeGramApp({super.key});

  @override
  State<VibeGramApp> createState() => _VibeGramAppState();
}

class _VibeGramAppState extends State<VibeGramApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeGram',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black, foregroundColor: Colors.white, elevation: 0),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: SplashScreen(onToggleTheme: _toggleTheme),
    );
  }
}

// 1. Landing / Splash Screen
class SplashScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const SplashScreen({super.key, required this.onToggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(onToggleTheme: widget.onToggleTheme)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pink, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.camera_alt, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.purple, Colors.pink, Colors.orange],
              ).createShader(bounds),
              child: const Text(
                'VibeGram',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Main Screen with Bottom Navigation
class MainScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const MainScreen({super.key, required this.onToggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(onToggleTheme: widget.onToggleTheme),
      const SearchScreen(),
      const ReelsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 28), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 28), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection, size: 28), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle, size: 28), label: 'Profile'),
        ],
      ),
    );
  }
}

// 3. Home Screen (Feed, Stories & Theme Switcher)
class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.purple, Colors.pink, Colors.orange],
          ).createShader(bounds),
          child: const Text('VibeGram', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [Colors.purple, Colors.pink, Colors.orange]),
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('https://picsum.photos/100?random=$index'),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(index == 0 ? 'Your Story' : 'user_$index', style: const TextStyle(fontSize: 11)),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            // Posts Feed
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => PostCard(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Post Card Widget with Double Tap Like
class PostCard extends StatefulWidget {
  final int index;
  const PostCard({super.key, required this.index});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isSaved = false;
  int likeCount = 124;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/100?random=${widget.index}')),
          title: Text('creator_${widget.index}', style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.more_vert),
        ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (!isLiked) {
                isLiked = true;
                likeCount++;
              }
            });
          },
          child: Image.network(
            'https://picsum.photos/500/500?random=${widget.index + 20}',
            height: 380,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : null),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                  likeCount += isLiked ? 1 : -1;
                });
              },
            ),
            IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
            IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
            const Spacer(),
            IconButton(
              icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () => setState(() => isSaved = !isSaved),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$likeCount likes', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                  children: [
                    TextSpan(text: 'creator_${widget.index} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'Exploring the web with VibeGram! 🚀 #FlutterWeb #InstagramClone'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}

// 5. Search Screen Grid
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: 21,
        itemBuilder: (context, index) => Image.network('https://picsum.photos/300?random=${index + 50}', fit: BoxFit.cover),
      ),
    );
  }
}

// 6. Reels Screen
class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Image.network('https://picsum.photos/600/900?random=${index + 80}', fit: BoxFit.cover, height: double.infinity, width: double.infinity),
              Positioned(
                bottom: 20,
                left: 15,
                child: Text('@reels_creator_$index\nTrending VibeGram Reel 🔥', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 7. Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('my_profile')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://picsum.photos/100?random=99')),
                Column(children: [Text('12', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Posts')]),
                Column(children: [Text('1.2k', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Followers')]),
                Column(children: [Text('450', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Following')]),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: 12,
              itemBuilder: (context, index) => Image.network('https://picsum.photos/300?random=${index + 100}', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}