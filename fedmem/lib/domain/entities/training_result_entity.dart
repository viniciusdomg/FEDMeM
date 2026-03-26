class TrainingResultEntity {
  final String status;
  final double accuracy;
  final double loss;
  final int epochsTrained;

  TrainingResultEntity({
    required this.status,
    required this.accuracy,
    required this.loss,
    required this.epochsTrained,
  });

  bool get isSuccess => status.toLowerCase().contains('sucesso');
}