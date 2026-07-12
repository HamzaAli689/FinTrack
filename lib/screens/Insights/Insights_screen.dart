import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../controllers/nav_controller.dart';
import 'package:todo/utils/app_colors.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Nav bar index sync
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NavController>().currentIndex.value = 1;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Finance Insights",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Pie Chart
            _buildChartContainer("Spending Distribution", _buildPieChart()),
            const SizedBox(height: 20),

            // 2. Bar Chart
            _buildChartContainer("Weekly Spending Trend", _buildBarChart()),
            const SizedBox(height: 20),

            // 3. Line Chart
            _buildChartContainer("Balance History", _buildLineChart()),
          ],
        ),
      ),
    );
  }

  // Common Wrapper
  Widget _buildChartContainer(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          SizedBox(height: 200, child: chart),
        ],
      ),
    );
  }

  // --- Charts Logic ---
  Widget _buildPieChart() => PieChart(
    PieChartData(
      sections: [
        PieChartSectionData(value: 40, color: AppColors.primary1, title: '40%'),
        PieChartSectionData(value: 30, color: Colors.blueAccent, title: '30%'),
        PieChartSectionData(value: 30, color: Colors.orange, title: '30%'),
      ],
    ),
  );

  Widget _buildBarChart() => BarChart(
    BarChartData(
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [BarChartRodData(toY: 8, color: AppColors.primary1)],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [BarChartRodData(toY: 10, color: AppColors.primary1)],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [BarChartRodData(toY: 7, color: AppColors.primary1)],
        ),
      ],
    ),
  );

  Widget _buildLineChart() => LineChart(
    LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: const [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 5)],
          isCurved: true,
          color: AppColors.primary1,
        ),
      ],
    ),
  );
}
