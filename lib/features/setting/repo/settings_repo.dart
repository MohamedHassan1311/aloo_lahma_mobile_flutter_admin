import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:aloo_lahma_admin/main_repos/base_repo.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class SettingsRepo extends BaseRepo {
  SettingsRepo({required super.dioClient, required super.sharedPreferences});

  Future<Either<ServerFailure, Response>> getSetting() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.settings);
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ApiErrorHandler.getServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }

  Future<Either<ServerFailure, Response>> getPrivacyPolicy() async {
    try {
      Response response =
          await dioClient.get(uri: EndPoints.pages("privacy-policy"));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ApiErrorHandler.getServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }

  Future<Either<ServerFailure, Response>> getTermsConditions() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.pages("terms"));

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ApiErrorHandler.getServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }

  Future<Either<ServerFailure, Response>> getAboutUs() async {
    try {
      Response response = await dioClient.get(uri: EndPoints.pages("about"));

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ApiErrorHandler.getServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ApiErrorHandler.getServerFailure(error));
    }
  }
}
