import 'package:app_template/data/models/auth.dart';
import 'package:app_template/data/models/requests/login_with_email_request.dart';
import 'package:app_template/domain/core/result.dart';

abstract class AuthRepository {
  Future<Result<Auth>> loginWithEmail({
    required LoginWithEmailRequest request,
  });
}
