abstract class FlowerGrpcDataSource {
  /// Conecta ao servidor e aguarda o envio dos pesos globais
  Future<List<List<double>>> receiveGlobalWeights();

  /// Envia os novos pesos treinados localmente de volta ao servidor
  Future<void> sendUpdatedWeights(List<List<double>> newWeights, int numSamples);
}