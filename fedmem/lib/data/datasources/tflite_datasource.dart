import '../models/training_metrics_model.dart';

abstract class TFLiteDataSource {
  /// Injeta os pesos globais, treina com os dados locais (fotos da palma forrageira)
  /// e devolve os novos pesos e métricas (loss e accuracy).
  Future<TrainingMetricsModel> trainLocally({
    required List<List<double>> globalWeights,
    required int epochs,
  });
}