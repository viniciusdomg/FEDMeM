import '../entities/training_result_entity.dart ';

abstract class IFederatedRepository{

  Future<TrainingResultEntity> executeAdaptiveFederatedRound();
}