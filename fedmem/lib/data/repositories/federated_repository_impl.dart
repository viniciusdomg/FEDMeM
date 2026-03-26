import '../../domain/repositories/i_federated_repository.dart';
import 'package:fedmem/domain/entities/training_result_entity.dart';
import '../datasources/hardware_datasource.dart';
import '../datasources/flower_grpc_datasource.dart';
import '../datasources/tflite_datasource.dart';

class FederatedRepositoryImpl implements IFederatedRepository {
  final HardwareDataSource hardwareDataSource;
  final FlowerGrpcDataSource grpcDataSource;
  final TFLiteDataSource tfLiteDataSource;

  FederatedRepositoryImpl({
    required this.hardwareDataSource,
    required this.grpcDataSource,
    required this.tfLiteDataSource,
  });

  @override
  Future<TrainingResultEntity> executeAdaptiveFederatedRound() async {
    try {
      // 1. Recebe os pesos do Orquestrador Python
      final globalWeights = await grpcDataSource.receiveGlobalWeights();

      // 2. Módulo Adaptativo (FedMEM): Verifica os recursos do dispositivo
      final battery = await hardwareDataSource.getBatteryLevel();
      final network = await hardwareDataSource.getNetworkType();

      // Regra de negócio adaptativa
      int epochsToTrain;
      if (battery < 20 || network == 'Mobile') {
        epochsToTrain = 1; // Modo de poupança de recursos
      } else {
        epochsToTrain = 3; // Modo de alto desempenho
      }

      // 3. Treina o modelo localmente com a carga computacional decidida
      final localMetrics = await tfLiteDataSource.trainLocally(
        globalWeights: globalWeights,
        epochs: epochsToTrain,
      );

      // 4. Envia os resultados de volta ao Orquestrador Python
      await grpcDataSource.sendUpdatedWeights(
        localMetrics.newWeights,
        localMetrics.samplesUsed,
      );

      return TrainingResultEntity(
        status: 'Sucesso',
        accuracy: localMetrics.accuracy,
        loss: localMetrics.loss,
        epochsTrained: epochsToTrain,
      );
    } catch (e) {
      return TrainingResultEntity(
        status: 'Erro na Federação: ${e.toString()}',
        accuracy: 0.0,
        loss: 0.0,
        epochsTrained: 0,
      );
    }
  }
}