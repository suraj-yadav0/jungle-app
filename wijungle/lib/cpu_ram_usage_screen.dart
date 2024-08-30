import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CpuRamUsageScreen extends StatefulWidget {
  const CpuRamUsageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CpuRamUsageScreenState createState() => _CpuRamUsageScreenState();
}

class _CpuRamUsageScreenState extends State<CpuRamUsageScreen> {
  double _cpuUsage = 0.0;
  double _ramUsage = 0.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchCpuRamData();
    });
  }

  Future<void> _fetchCpuRamData() async {
    try {
     // Here the data will be replaced after feteching 
      final cpuUsage = await _mockFetchCpuUsage();
      final ramUsage = await _mockFetchRamUsage();

      setState(() {
        _cpuUsage = cpuUsage;
        _ramUsage = ramUsage;
      });
    } catch (e) {
      // Handle errors as needed
      print('Failed to fetch CPU/RAM data: $e');
    }
  }

  Future<double> _mockFetchCpuUsage() async {
    // Simulate fetching CPU usage
    return 0.76; // 76% CPU usage
  }

  Future<double> _mockFetchRamUsage() async {
    // Simulate fetching RAM usage
    return 0.76; // 76% RAM usage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          _buildSideBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildUsageIndicator("CPU", _cpuUsage),
                  _buildUsageIndicator("RAM", _ramUsage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar() {
    return Container(
      width: 150,
      color: const Color(0xFF2C3E50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/wijungle_logo.png'),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.analytics, color: Colors.white),
            title: Text(
              'Analytics',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.white),
            title: Text(
              'Feedback',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUsageIndicator(String label, double usage) {
    return CircularPercentIndicator(
      radius: 150.0,
      lineWidth: 15.0,
      animation: true,
      percent: usage,
      center: Text(
        "${(usage * 100).toStringAsFixed(0)}%\n$label",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.blue,
      backgroundColor: Colors.grey.shade300,
    );
  }
}
