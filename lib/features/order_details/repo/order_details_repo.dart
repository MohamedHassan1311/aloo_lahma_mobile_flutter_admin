import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../data/api/end_points.dart';
import '../../../../../data/error/api_error_handler.dart';
import '../../../../../data/error/failures.dart';
import '../../../../../main_repos/base_repo.dart';

class OrderDetailsRepo extends BaseRepo {
  OrderDetailsRepo(
      {required super.dioClient, required super.sharedPreferences});

  Future<Either<ServerFailure, Response>> getOrderDetails(id) async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.orderDetails(userType,id),
        queryParameters: {
          "with": "invoice.user,invoice.shipping,invoice.bank,invoice.bankTransfer,driver,products.product,products.gift,products.items.item,orderStatusLogs"
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
