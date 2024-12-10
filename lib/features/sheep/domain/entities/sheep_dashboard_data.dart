class SheepDashboardData {
  final int totalSheep;
  final Map<String, int> stageDistribution;
  final Map<String, int> statusDistribution;
  final Map<String, int> monthlyGrowth;
  final int totalSessions;
  final int completedSessions;

  SheepDashboardData({
    required this.totalSheep,
    required this.stageDistribution,
    required this.statusDistribution,
    required this.monthlyGrowth,
    required this.totalSessions,
    required this.completedSessions,
  });
}
