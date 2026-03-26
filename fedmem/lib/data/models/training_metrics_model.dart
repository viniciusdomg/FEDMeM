class TrainingMetricsModel {
  final List<List<double>> newWeights;
  final double loss;
  final double accuracy;
  final int samplesUsed;

  TrainingMetricsModel({
    required this.newWeights,
    required this.loss,
    required this.accuracy,
    required this.samplesUsed,
  });
}