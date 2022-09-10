import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_restaurant/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckMembershipRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  CheckMembershipRepo(
      {@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> checkMembership() async {
    try {
      final userId = sharedPreferences.getString(AppConstants.USER_ID) ?? "";
      final response = await Dio().post(
        'https://admin.mingskitchen.ca/api/v1/checkmembership',
        data: {
          'user_id': userId,
        },
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
