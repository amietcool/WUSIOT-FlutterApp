import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WorkerDetails extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String gender;
  final String? zone;
  final int age;

  const WorkerDetails({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.zone,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [Icon(Icons.settings, color: Colors.black)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(name: name, imageUrl: imageUrl, gender: gender, age: age),
            BiometricSection(),
            EnvironmetricsSection(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String gender;
  final int age;

  const ProfileHeader({
    required this.name,
    required this.imageUrl,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            width: 65,
            height: 65,
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$gender ', style: TextStyle(color: Colors.amber)),
            Text('| Noida |', style: TextStyle(color: Colors.black45)),
            Text(' Age: $age', style: TextStyle(color: Colors.amber))
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

// The BiometricSection and EnvironmetricsSection remain the same.
class BiometricSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionContainerBio(
      title: 'Biometrics',
      children: [
        InfoCard(title: 'Heart Rate', value: '78.2 BPM', color: Colors.blue),
        InfoCard(title: 'Blood Pressure', value: '120 mmHg', color: Colors.red),
        InfoCard(title: 'Temperature', value: '37°C', color: Colors.teal),
      ],
    );
  }
}

class EnvironmetricsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: 'Environmetrics',
      children: [
        InfoCard( value: '24°C', title: 'Temperature', color: Colors.blueGrey),
        InfoCard( value: '45%', title: 'Humidity',color: Colors.green),
        InfoCard( value: '0 ppm', title: 'CO₂',color: Colors.red),
        InfoCard( value: '0 ppm', title: 'Gas',color: Colors.blue),
      ],
    );
  }
}

class SectionContainerBio extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SectionContainerBio({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  SectionContainer({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              // Wrap Text with Center
              child: Text(
                title,
                textAlign: TextAlign.center,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8.0),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  InfoCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
            Spacer(),
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

