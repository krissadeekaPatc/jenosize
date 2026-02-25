import 'package:app_template/data/models/user.dart';
import 'package:app_template/domain/core/result.dart';

abstract class UserRepository {
  Future<Result<User>> me();
}
