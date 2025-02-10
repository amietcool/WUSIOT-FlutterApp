import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ZoneDashboard extends StatelessWidget {
  const ZoneDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "All Zones Dashboard",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("WORKERS IN DIFFERENT ZONES"),
            SizedBox(height: 8),
            _buildWorkerCard(),
            SizedBox(height: 20),
            _buildTitle("AVERAGE HEALTH RATE OF ALL ZONES"),
            SizedBox(height: 8),
            _buildHealthIndexCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildWorkerCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 120,
              child: Center(
                child: Column(
                  children: [
                    //Text("Caved", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    //Text("326 WORKERS", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 12),
            _buildWorkerStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerStats() {
    return Column(
      children: [
        _workerStat("Caved zone", "27%", Colors.blue),
        _workerStat("Fractured zone", "23%", Colors.orange),
        _workerStat("Bending subsidence zone", "22%", Colors.purple),
        _workerStat("OTHERS", "28%", Colors.red),
      ],
    );
  }

  Widget _workerStat(String label, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: color),
          SizedBox(width: 8),
          Expanded(child: Text(label)),
          Text(percentage, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHealthIndexCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("HEALTH INDEX", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.trending_up, color: Colors.red),
              ],
            ),
            Row(
              children: [
                Text(
                  "75%",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(width: 8),
                Text("Worker health rate", style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 12),
            Container(height: 150, child: _buildHealthChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                List<String> months = ["June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"];
                return Text(months[value.toInt()], style: TextStyle(fontSize: 10));
              },
              interval: 1,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 2),
              FlSpot(1, 3),
              FlSpot(2, 4),
              FlSpot(3, 6),
              FlSpot(4, 5),
              FlSpot(5, 7),
            ],
            isCurved: true,
            //color: [Colors.blue],
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
          ),
        ],
      ),
    );
  }
}
