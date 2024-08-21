import 'package:dartz/dartz.dart';
import 'package:flutter_rick_and_morties/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
