import 'dart:convert';

import 'package:get/get.dart';
import 'package:louvor_ics_patos/utils/api_response.dart';

class OnesignalService  extends GetConnect{
   Future<ApiResponse<bool>> notificar(
      String headings, String content) async {
    try {
      var url = "https://onesignal.com/api/v1/notifications";

      final Map params = {
        "included_segments": ["Subscribed Users"],
        // "include_external_user_ids": ["074de711-1d12-4685-ac32-c8710dd4e0c5",],
        "headings": {"en": headings},
        "contents": {"en": content},
        "app_id": "f481e37e-b438-46fd-9f58-5bc6054f502e",
      };

      String s = json.encode(params);
      var response = await post(url,  s, headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Basic YTZmNzczMDQtNDk5ZS00ZmJmLWJhYWUtMzllNzU1NjZmMTAy"
      });
      print('POST >> $url  Status: ${response.statusCode}');

      Map mapResponse = json.decode(response.bodyString);
      print(mapResponse);
      if (response.statusCode == 200) {
        return ApiResponse.ok(result: true);
      }
      return ApiResponse.error(msg: mapResponse['erro']);
    } catch (error, exception) {
      print('Erro ao enviar notificação: $error > $exception');
      return ApiResponse.error(msg: 'Erro ao enviar notificação');
    }
  }
}
