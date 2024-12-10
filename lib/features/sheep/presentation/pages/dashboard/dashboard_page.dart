import 'package:brm/core/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/entities/sheep.dart';
import 'bloc/sheep_dashboard_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SheepDashboardCubit(Modular.get(), Modular.get())
          ..loadDashboardData();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Sheep Dashboard')),
        body: BlocBuilder<SheepDashboardCubit, SheepDashboardState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            if (state.dashboardData == null) {
              return Center(child: Text('No data available'));
            }

            // Your existing dashboard build logic,
            // but now using state.dashboardData and state.recentSheep
            return _buildDashboardContent(state);
          },
        ),
      ),
    );
  }

  Widget _buildDashboardContent(SheepDashboardState state) {
    final dashboardData = state.dashboardData;
    final recentSheep = state.recentSheep ?? [];

    if (dashboardData == null) return SizedBox.shrink();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard(
                icon: Icons.people,
                title: 'Total Sheep',
                value: dashboardData.totalSheep.toString(),
              ),
              _buildStatCard(
                icon: Icons.calendar_today,
                title: 'Total Sessions',
                value:
                    '${dashboardData.completedSessions} / ${dashboardData.totalSessions}',
              ),
              _buildStatCard(
                icon: Icons.check_circle,
                title: 'Completion Rate',
                value: dashboardData.totalSessions > 0
                    ? '${(dashboardData.completedSessions / dashboardData.totalSessions * 100).toStringAsFixed(0)}%'
                    : '0%',
              ),
            ],
          ),

          SizedBox(height: 20),

          // Charts Section
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Stages'),
                    Tab(text: 'Status'),
                    Tab(text: 'Growth'),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    children: [
                      // Stage Distribution Chart
                      _buildPieChart(dashboardData.stageDistribution),

                      // Status Distribution Chart
                      _buildPieChart(dashboardData.statusDistribution),

                      // Monthly Growth Chart
                      _buildBarChart(dashboardData.monthlyGrowth),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Recent Sheep Table
          Text(
            'Recent Sheep',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          _buildRecentSheepTable(recentSheep),
        ],
      ),
    );
  }

// Utility widgets (these can be extracted to a separate file)
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> data) {
    return SfCircularChart(
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: <CircularSeries>[
        PieSeries<MapEntry<String, int>, String>(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
          ),
        )
      ],
    );
  }

  Widget _buildRecentSheepTable(List<Sheep> recentSheep) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Stage')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Sessions')),
          ],
          rows: recentSheep
              .map((sheep) => DataRow(cells: [
                    DataCell(Text(sheep.name)),
                    DataCell(Text(sheep.stage.value.capitalize())),
                    DataCell(Text(sheep.status.value.capitalize())),
                    DataCell(
                        Text('${sheep.sessionsDone}/${sheep.totalSessions}')),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildBarChart(Map<String, int> data) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: [
        ColumnSeries<MapEntry<String, int>, String>(
          dataSource: data.entries.toList(),
          xValueMapper: (entry, _) => entry.key,
          yValueMapper: (entry, _) => entry.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
