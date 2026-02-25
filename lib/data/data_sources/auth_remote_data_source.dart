import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jenosize/data/models/auth.dart';
import 'package:jenosize/data/models/requests/login_with_email_request.dart';
import 'package:jenosize/generated/assets.gen.dart';

class AuthRemoteDataSource {
  final AssetBundle bundle;

  AuthRemoteDataSource({required this.bundle});

  Future<Auth> loginWithEmail({required LoginWithEmailRequest request}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final String response = await bundle.loadString(Assets.mocks.auth);

    return Auth.fromJson(json.decode(response));
  }
}
