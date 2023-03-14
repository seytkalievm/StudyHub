// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../../../model/repository/auth_repository.dart';
// import '../../../common/constants.dart';
// import '../../../model/models/resource.dart';
// import '../../../model/models/tokens.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'dart:html' as html;
//
//
// class WebLoginWithIUUseCase {
//   const WebLoginWithIUUseCase._();
//
//
//   static Future<Resource<Token>> invoke() async {
//
//     // AuthRepository authRepo = Get.find();
//     //
//     // final result = await FlutterWebAuth.authenticate(
//     //   url: authorizationUri,
//     //   callbackUrlScheme: "https",
//     // );
//     //
//     // debugPrint(result);
//     //
//     // final token = Uri.parse(result).queryParameters['token'];
//
//
//     html.WindowBase? _popupWin;
//
//     final currentUri = Uri.base;
//
//     final redirectUri = Uri(
//       host: currentUri.host,
//       scheme: currentUri.scheme,
//       port: currentUri.port,
//       path: '/static.html',
//     );
//
//     debugPrint("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//     debugPrint(redirectUri.toString());
//     debugPrint("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//
//     _popupWin = html.window.open(
//       authorizationUri,
//       "Innopolis University",
//       "width=800, height=900, scrollbars=yes",
//     );
//
//
//     void _login(String data) {
//       /// Parse data into an Uri to extract the token easily.
//       final receivedUri = Uri.parse(data);
//       debugPrint(receivedUri.toString());
//
//       /// Close the popup window
//       if (_popupWin != null) {
//         _popupWin!.close();
//         _popupWin = null;
//       }
//     }
//
//     html.window.onMessage.listen((event) {
//       /// If the event contains the token it means the user is authenticated.
//       if (event.data.toString().contains('access_token=')) {
//         _login(event.data);
//       }
//     });
//
//
//
//     return Fail(errorMessage: "kek");
//   }
// }
