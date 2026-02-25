import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/result.dart';

abstract class UserRepository {
  Future<Result<User>> getProfile();
}
