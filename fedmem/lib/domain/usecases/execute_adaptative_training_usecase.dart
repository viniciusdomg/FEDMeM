import 'package:fedmem/domain/entities/training_result_entity.dart';
import '../repositories/i_federated_repository.dart';

/// Caso de uso responsável por iniciar a rodada do Aprendizado Federado Adaptativo.
class ExecuteAdaptiveTrainingUseCase {
  final IFederatedRepository repository;

  // Injeção de dependência: O Use Case recebe a interface, não a implementação.
  ExecuteAdaptiveTrainingUseCase(this.repository);

  /// O método call() permite que a instância da classe seja chamada como uma função
  Future<TrainingResultEntity> call() async {
    var result = await repository.executeAdaptiveFederatedRound();
    // Aqui nós poderíamos ter validações extras de negócio (ex: verificar se o
    // produtor tem permissão), mas no nosso caso, delegamos diretamente para o
    // repositório iniciar o fluxo do FedMEM.
    return result;
  }
}