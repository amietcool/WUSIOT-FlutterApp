import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wusiotapp/api/WebServiceRequests.dart';
import 'package:wusiotapp/api/WorkerListResponse.dart';
import 'package:wusiotapp/worker/WorkerDetails.dart';

class Worker extends StatelessWidget {
  const Worker({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkersScreen(),
    );
  }
}

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  _WorkersScreenState createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  List<WorkerData> workers = [];

  @override
  void initState() {
    super.initState();
    getWorkerListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/image/illzone.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 50),

              // Worker Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26, width: 2),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "Caved Zone",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Worker Details",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Divider(color: Colors.black54),
                      SizedBox(height: 5),
                      Text(
                        "Total Workers",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "37",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Name....",
                    prefixIcon: const Icon(Icons.search, color: Colors.amber),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.amber, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.amber, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.amber, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Worker List
              Expanded(
                child: workers.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: workers.length,
                  itemBuilder: (context, index) {
                    return WorkerCard(workerData: workers[index]);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fetch Worker List from API
  void getWorkerListApi() async {
    final api = WebServiceRequests();

    try {
      final response = await api.getWorkerList(1);
      Map<String, dynamic> jsonMap = jsonDecode(response.toString());
      WorkerListResponse responseWorker = WorkerListResponse.fromJson(jsonMap);

      if (responseWorker.responseCode == 200) {
        setState(() {
          workers = responseWorker.data;
        });
      } else {
        _showToast(responseWorker.successMessage);
      }
    } catch (e) {
      print(e);
      _showToast("Failed to load workers");
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.amber,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class WorkerCard extends StatelessWidget {
  final WorkerData workerData;

  const WorkerCard({Key? key, required this.workerData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Profile Image
              CircleAvatar(
                backgroundImage: AssetImage('assets/image/user_placeholder.png'), // Default image
                radius: 20,
              ),
              const SizedBox(width: 10),
              // Worker Name
              Text(
                workerData.worker.username,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // View Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkerDetails(
                    name: workerData.worker.username,
                    imageUrl: "https://wusadmin.workerunionsupport.com/assets/demo/demo5/media/img/logo/logo.png",
                    gender: "Male",
                    zone: workerData.worker.workArea,
                    age: workerData.worker.age,
                  ),
                ),
              );
            },
            child: const Text(
              "View",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

