import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';
import 'package:jenosize/domain/core/result.dart';

abstract class AuthRepository {
  Future<Result<Auth>> loginWithEmail({
    required LoginWithEmailRequest request,
  });
}
