import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:aloo_lahma_admin/features/auth/verification/model/verification_model.dart';
import '../../../../data/api/end_points.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../../main_repos/base_repo.dart';

class VerificationRepo extends BaseRepo {
  VerificationRepo(
      {required super.sharedPreferences, required super.dioClient});

  Future<Either<ServerFailure, Response>> resendCode(
      VerificationModel model) async {
    try {
      Response response = await dioClient.post(
        uri: EndPoints.forgetPassword(userType),
        data: model.toJson(withCode: false),
      );

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }

  Future<Either<ServerFailure, Response>> verifyAccount(
      VerificationModel model) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.verifyOtp(userType), data: model.toJson());
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }
}
