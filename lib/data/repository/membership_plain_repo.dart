import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_restaurant/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';

class MembershipPlainRepo {
  final DioClient dioClient;
  MembershipPlainRepo({@required this.dioClient});

  Future<ApiResponse> getMemberhipPlans() async {
    try {
      final response = await dioClient.get(AppConstants.MEMBERSHIP_PLAN_URI);
      print(response.toString() + "ghgghjbjbj");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString() + "ggggg");

      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
