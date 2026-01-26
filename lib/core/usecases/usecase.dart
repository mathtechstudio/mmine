import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';

/// Base class for all use cases in the application.
///
/// Use cases encapsulate business logic and represent a single action
/// that can be performed in the application. They follow the Single
/// Responsibility Principle and the Clean Architecture pattern.
///
/// Type parameters:
/// - [Type]: The return type of the use case
/// - [Params]: The parameters required by the use case
///
/// All use cases return [Either<Failure, Type>] to enable functional
/// error handling without exceptions.
///
/// Example implementation:
/// ```dart
/// class GetUserUseCase implements UseCase<User, String> {
///   final UserRepository repository;
///
///   GetUserUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, User>> call(String userId) async {
///     return await repository.getUser(userId);
///   }
/// }
/// ```
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given [params].
  ///
  /// Returns [Right] with the result on success, or [Left] with a
  /// [Failure] if the operation fails.
  Future<Either<Failure, Type>> call(Params params);
}

/// Empty parameter class for use cases that don't require parameters.
///
/// Use this instead of void or null when a use case doesn't need
/// any input parameters.
///
/// Example usage:
/// ```dart
/// class GetAllUsersUseCase implements UseCase<List<User>, NoParams> {
///   @override
///   Future<Either<Failure, List<User>>> call(NoParams params) async {
///     // Implementation
///   }
/// }
///
/// // Usage
/// final result = await getAllUsersUseCase(NoParams());
/// ```
class NoParams {
  const NoParams();
}
