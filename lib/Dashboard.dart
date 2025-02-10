import 'package:flutter/material.dart';
import 'package:wusiotapp/worker/Worker.dart';
import 'package:wusiotapp/worker/ZoneDashboard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
        );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

/*  @override
  _SelectZoneScreenState createState() => _SelectZoneScreenState();*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // Title
            const Text(
              "WUS KAVACH",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Top Image Illustration
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Worker()));
                  },
                  child: Image.asset(
                    'assets/image/main.png',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Welcome Text
            const Text(
              "Welcome back!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),
            // Select Zone Title
            const Text(
              "Select Zone",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            // Carousel Slider for Zone Selection
            /*CarouselSlider(
              options: CarouselOptions(
                height: 180,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
              items: [
                zoneCard("Caved Zone", 37, 24, "assets/team_avatar.png"),
                zoneCard("Open Zone", 42, 30, "assets/team_avatar.png"),
                zoneCard("Restricted Zone", 28, 18, "assets/team_avatar.png"),
              ],
            ),*/

            const SizedBox(height: 10),
            // Pagination Dots
            const Icon(Icons.more_horiz, size: 30, color: Colors.black54),

            const SizedBox(height: 10),
            // "See all" button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ZoneDashboard()));
              },
              child: const Text(
                "See all",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // Widget for Zone Card
  Widget zoneCard(String zoneName, int totalPresent, int teamSize, String avatarPath) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(zoneName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const Text("Worker details", style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Present Count
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Present:", style: TextStyle(fontSize: 12, color: Colors.black54)),
                  Text(
                    totalPresent.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),

              // Team Members Avatar
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(avatarPath),
                    radius: 12,
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundImage: AssetImage(avatarPath),
                    radius: 12,
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundImage: AssetImage(avatarPath),
                    radius: 12,
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "+$teamSize",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}

/*class SelectZoneScreen extends StatefulWidget {
  @override
  _SelectZoneScreenState createState() => _SelectZoneScreenState();
}

class _SelectZoneScreenState extends State<SelectZoneScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _zones = [
    {"name": "Caved Zone", "totalPresent": 37},
    {"name": "Open Zone", "totalPresent": 42},
    {"name": "Restricted Zone", "totalPresent": 25},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 10),
            child: Text(
              "Select Zone",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            items: _zones.map((zone) {
              return Builder(builder: (BuildContext context) {
                return ZoneCard(zone: zone);
              });
            }).toList(),
            options: CarouselOptions(
              height: 250,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.7,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _zones.map((zone) {
              int index = _zones.indexOf(zone);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.orange : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ZoneCard extends StatelessWidget {
  final Map<String, dynamic> zone;

  const ZoneCard({Key? key, required this.zone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      shadowColor: Colors.black54,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange, width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              zone['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Worker details",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Total Present: ",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        value: zone['totalPresent'] / 50, // Assuming max 50 workers
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation(Colors.blue),
                        strokeWidth: 5,
                      ),
                    ),
                    Text(
                      "${zone['totalPresent']}",
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Team"),
            const SizedBox(height: 5),
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/user1.jpg"),
                ),
                const SizedBox(width: 4),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/user2.jpg"),
                ),
                const SizedBox(width: 4),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/user3.jpg"),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "+24",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}*/
