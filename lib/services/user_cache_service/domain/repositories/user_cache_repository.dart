import 'package:dartz/dartz.dart'; 
import 'package:khalti_task/shared/domain/models/models.dart';
import 'package:khalti_task/shared/exceptions/http_exception.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
