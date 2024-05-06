import 'dart:convert';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:moe_cfims/infrastructure/core/dioClient.dart';
import 'package:moe_cfims/domain/auth/i_auth_facade.dart';
import 'package:moe_cfims/domain/auth/auth_failure.dart';
import 'package:moe_cfims/domain/auth/auth_value_objects.dart';
import 'package:moe_cfims/infrastructure/core/hive_box_names.dart';
import 'package:moe_cfims/presentation/common/untils/get_cookie.dart';
import 'package:moe_cfims/presentation/common/untils/constant.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final DioClient _dio;
  AuthFacade(this._dio);

  @override
  Future<Either<AuthFailure, Unit>> login({required EmailAddress emailAddress}) async {
    final emailString = emailAddress.getOrCrash();

    try {
      var queryParams = {
        'email': emailString
      };
      final responseData = await _dio.get(ApiConstant.getAuthDomain, queryParameters: queryParams);
      final List<dynamic> results = jsonDecode(responseData);
      String emailDomain = emailString.substring(emailString.indexOf('@', emailString.length));
      final item = results.firstWhere((element) => element['domain'].toString() == emailDomain);
      final domain = item['domain'].toString();
      if (domain.isNotEmpty) {
        signInWithWebUIProvider(domain);
      } else {
        signInWithWebUI();
      }

      return right(unit);
    } on DioException catch (err) {
      if (err.response?.statusCode == 401) {
        // return left(const AuthFailure.invalidCredentials());
      }
      return left(const AuthFailure.serverError());
    } on SocketException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<bool> checkAuthenticated() async {
    // getCookie returns null as a String, so it has to be checked like this.
    return getCookie() != "null";
  }

  @override
  Future<void> logout() async {
    try {
      Future.wait([
        Hive.box(BoxNames.settingsBox).clear(),
        // Hive.box<AccountEntity>(BoxNames.currentUser).clear(),
        _dio.post("/account/logout"),
      ]);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> signInWithWebUI() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      safePrint('Sign in result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> signInWithWebUIProvider(String domain) async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.custom(domain),
      );
      safePrint('Result: $result');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final token = result.userPoolTokensResult.value.accessToken.toString();
      if (token.isNotEmpty) {
        _setCookie(token);
      }
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }

  Future<void> _setCookie(String cookie) async {
    // Hacky solution to allow testing
    if (!Platform.environment.containsKey('MOE_TEST')) {
      if (cookie.isNotEmpty) {
        await Hive.box(BoxNames.settingsBox).put(BoxKeys.currentToken, cookie);
      }
    }
  }

  // void _setUserData(Account account) {
  //   // Hacky solution to allow testing
  //   if (!Platform.environment.containsKey('MOE_TEST')) {
  //     final box = Hive.box<AccountEntity>(BoxNames.currentUser);
  //     box.put(BoxKeys.currentKey, AccountEntity.fromDomain(account));
  //   }
  // }
}
