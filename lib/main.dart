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
  String currentAccount = "creator_0";
  final List<String> accounts = ["creator_0", "vibegram_user1", "vibegram_user2", "creator_pro", "market_demo"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeGram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      home: MainFeedScreen(
        currentAccount: currentAccount,
        accounts: accounts,
        onAccountSwitch: (acc) {
          setState(() {
            currentAccount = acc;
          });
        },
      ),
    );
  }
}

class MainFeedScreen extends StatefulWidget {
  final String currentAccount;
  final List<String> accounts;
  final ValueChanged<String> onAccountSwitch;

  const MainFeedScreen({
    super.key,
    required this.currentAccount,
    required this.accounts,
    required this.onAccountSwitch,
  });

  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeFeedTab(currentAccount: widget.currentAccount),
      const SearchTab(),
      const ReelsTab(),
      ProfileTab(currentAccount: widget.currentAccount),
    ];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // Account switcher bottom sheet
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.grey[900],
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Switch Account (Market Demo)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.accounts.length,
                          itemBuilder: (context, index) {
                            final acc = widget.accounts[index];
                            return ListTile(
                              leading: const CircleAvatar(backgroundColor: Colors.purple, child: Icon(Icons.person, color: Colors.white)),
                              title: Text(acc, style: const TextStyle(color: Colors.white)),
                              trailing: widget.currentAccount == acc ? const Icon(Icons.check, color: Colors.blue) : null,
                              onTap: () {
                                widget.onAccountSwitch(acc);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Row(
            children: [
              Text('VibeGram (${widget.currentAccount})', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cursive', fontSize: 24)),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class HomeFeedTab extends StatelessWidget {
  final String currentAccount;
  const HomeFeedTab({super.key, required this.currentAccount});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Stories Bar
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Colors.purple, Colors.orange, Colors.yellow]),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://picsum.photos/seed/story$index/100'),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(index == 0 ? 'Your Story' : 'user_$index', style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: Colors.grey, height: 1),
        // Post Feed
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/seed/user$index/100')),
                  title: Text('creator_$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.more_vert, color: Colors.white),
                ),
                Image.network('https://picsum.photos/seed/post$index/600/400', fit: BoxFit.cover, height: 350, width: double.infinity),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.send_outlined, color: Colors.white), onPressed: () {}),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white), onPressed: () {}),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Liked by user_1 and ${index * 14 + 5} others', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('creator_$index: Loving this wonderful vibe! #vibegram #marketpresentation', style: const TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ],
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Image.network('https://picsum.photos/seed/search$index/200', fit: BoxFit.cover);
      },
    );
  }
}

class ReelsTab extends StatelessWidget {
  const ReelsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.network('https://picsum.photos/seed/reel$index/600/900', fit: BoxFit.cover),
            Positioned(
              bottom: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('@reel_creator_$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  const Text('Amazing VibeGram reel content! 🚀', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProfileTab extends StatelessWidget {
  final String currentAccount;
  const ProfileTab({super.key, required this.currentAccount});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const CircleAvatar(radius: 40, backgroundColor: Colors.purple, child: Icon(Icons.person, size: 40, color: Colors.white)),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [Text('15', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Posts')]),
                    Column(children: [Text('1.2M', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Followers')]),
                    Column(children: [Text('180', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('Following')]),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentAccount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text('Official VibeGram Creator Account ✨\nPresenting live to the market today!'),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(35)),
                child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Image.network('https://picsum.photos/seed/profile$index/200', fit: BoxFit.cover);
          },
        ),
      ],
    );
  }
}