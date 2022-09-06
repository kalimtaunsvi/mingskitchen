import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_restaurant/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';

class CheckMembershipRepo {
  final DioClient dioClient;
  CheckMembershipRepo({@required this.dioClient});

  Future<ApiResponse> checkMembership() async {
    print("checkUserMembership repo");
    try {
      final response = await Dio().post(
        'https://admin.mingskitchen.ca/api/v1/checkmembership',
        data: {
          'user_id': 12,
        },
      );
      print(response.toString() + "checkUserMembership response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("checkUserMembership error " + e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
