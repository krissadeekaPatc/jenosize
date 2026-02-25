import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/generated/assets.gen.dart';

class UserRemoteDataSource {
  final AssetBundle bundle;

  UserRemoteDataSource({required this.bundle});

  Future<User> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));

    final String response = await bundle.loadString(Assets.mocks.user);

    final Map<String, dynamic> data = json.decode(response);

    return User.fromJson(data);
  }
}
