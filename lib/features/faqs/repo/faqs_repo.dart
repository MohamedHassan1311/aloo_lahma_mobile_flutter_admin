import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import 'package:aloo_lahma_admin/main_repos/base_repo.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class FaqsRepo extends BaseRepo {
  FaqsRepo({required super.dioClient, required super.sharedPreferences});

  Future<Either<ServerFailure, Response>> getFaqs(SearchEngine data) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.faqs,
        queryParameters: {
          "page": data.currentPage! + 1,
          "limit": data.limit,
        },
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
}
