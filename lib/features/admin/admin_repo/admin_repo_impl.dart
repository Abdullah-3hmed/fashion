// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:e_fashion_flutter/core/error/error_model.dart';
// import 'package:e_fashion_flutter/core/error/failures.dart';
// import 'package:e_fashion_flutter/core/error/server_exception.dart';
// import 'package:e_fashion_flutter/core/network/api_constants.dart';
// import 'package:e_fashion_flutter/core/network/dio_helper.dart';
// import 'package:e_fashion_flutter/core/utils/app_constants.dart';
// import 'package:e_fashion_flutter/features/admin/admin_repo/admin_repo.dart';
// import 'package:e_fashion_flutter/features/admin/data/chat_model.dart';
//
// class AdminRepoImpl implements AdminRepo {
//   final DioHelper dioHelper;
//
//   AdminRepoImpl({required this.dioHelper});
//
//   @override
//   Future<Either<Failure, List<ChatModel>>> getAllChats() async {
//     try {
//       final response = await dioHelper.get(
//         url: ApiConstants.allChatsEndPoint,
//         headers: {"Authorization": "Bearer ${AppConstants.token}"},
//       );
//       if (response.statusCode == 200) {
//         return Right(
//           List<ChatModel>.from(
//             (response.data as List? ?? []).map(
//               (chat) => ChatModel.fromJson(chat),
//             ),
//           ),
//         );
//       } else {
//         throw ServerException(errorModel: ErrorModel.fromJson(response.data));
//       }
//     } on DioException catch (e) {
//       return Left(ServerFailure.fromDioError(e));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.errorModel.errors.join(" \n")));
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
