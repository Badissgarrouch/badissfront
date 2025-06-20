import 'package:credit_app/core/class/crud.dart';
import 'package:credit_app/linkapi.dart';

import '../../../../core/class/statusrequest.dart';

class DeleteFriendshipData {
  final Crud crud;

  DeleteFriendshipData(this.crud);

  Future<Map<String, dynamic>> deleteData({
    required String token,
    required String friendId,
  }) async {
    try {
      final response = await crud.deleteData(
        "${AppLink.deleteFriendship}?friendId=$friendId", // Envoyé dans l'URL
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      return response.fold(
            (failure) => {
          "status": "error",
          "message": failure.toString(),
          "code": (failure as StatusRequest).toString()
        },
            (success) => success is Map<String, dynamic>
            ? success
            : {"status": "error", "message": "Invalid response format"},
      );
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }
}