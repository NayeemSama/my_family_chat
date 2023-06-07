// import 'dart:async';
// import 'dart:io';
//
//
// import 'package:familychat/models/api_response_model.dart';
// import 'package:familychat/utils/const_keys.dart';
// import 'package:familychat/utils/logger.dart';
// import 'package:familychat/widgets/loader.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'global_services.dart';
// import 'package:dio/dio.dart' as dio;
//
// class NetworkFunctions {
//   final GlobalKey<ScaffoldState>? scaffoldKey;
//
//   /// success callback function
//   Function(dynamic)? isSuccess;
//
//   /// error callback function
//   Function(dynamic)? isError;
//
//   /// loading view message
//   var loadingMessage = "loading...";
//   var networkErrorMessage = "";
//   var networkError;
//   bool isNetworkError = false;
//
//   NetworkFunctions({this.scaffoldKey});
//
//   /// post api call common handler
//   Future<dynamic> postApiRequest(var url,
//       {Map<String, dynamic>? data,
//       String contentType = 'application/json; charset=utf-8',
//       bool isShowLoader = true,
//       BuildContext? context}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = contentType;
//
//       print(headers.toString());
//
//       /// print request data
//       Logger.printLog(
//           tag: 'POST METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       /// call api
//       http.Response response = await http.post(
//         url,
//         body: jsonEncode(data),
//         headers: headers,
//         encoding: Encoding.getByName("utf-8"),
//       );
//       print("out");
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         //dismissDialogs();
//         print("outBack");
//
//         /// dismiss progress dialog
//         Get.back();
//         // Navigator.of(context!).pop(true);
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Get.back();
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// post api call common handler
//   Future<dynamic> postJsonEncodeDataApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = "application/json";
//       headers['Accept'] = "application/json";
//
//       /// print request data
//       Logger.printLog(
//           tag: 'POST JSON METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//       var jsonEncodeData = json.encode(data);
//
//       /// call api
//       http.Response response = await http.post(
//         url,
//         body: jsonEncodeData,
//         headers: headers,
//         encoding: Encoding.getByName("utf-8"),
//       );
//
//       if (isShowLoader) {
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       // Map userMap = jsonDecode(response.body);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// row data post api call common handler
//   Future<dynamic> postRowDataApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = "application/json";
//       headers['Accept'] = "application/json";
//
//       /// print request data
//       Logger.printLog(
//           tag: 'POST ROW JSON METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       /// call api
//       http.Response response = await http.post(
//         url,
//         body: jsonEncode(data),
//         headers: headers,
//         encoding: Encoding.getByName("utf-8"),
//       );
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       // Map userMap = jsonDecode(response.body);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// put api call common handler
//   Future<dynamic> putApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//
//       Map<String, String> headers = await GlobalServices.getHeaders();
//
//       /// print request data
//       Logger.printLog(
//           tag: 'PUT METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       /// call api
//       http.Response response = await http.put(
//         url,
//         body: data,
//         headers: headers,
//         encoding: Encoding.getByName("utf-8"),
//       );
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       // Map userMap = jsonDecode(response.body);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// put api call common handler
//   Future<dynamic> putJsonEncodeDataApiRequest(var url,
//       {Map<String, dynamic>? data, List<dynamic>? listData, bool isShowLoader = true, bool isArrayList = false}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = "application/json";
//       headers['Accept'] = "application/json";
//
//       /// print request data
//       Logger.printLog(
//           tag: 'PUT JSON METHOD \n\n REQUEST_URL :',
//           printLog:
//               '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${isArrayList == false ? data.toString() : json.encode(listData).toString()}',
//           logIcon: Logger.info);
//
//       var jsonEncodeData;
//       if (isArrayList) {
//         jsonEncodeData = json.encode(listData);
//       } else {
//         jsonEncodeData = json.encode(data);
//       }
//
//       /// call api
//       http.Response response = await http.put(
//         url,
//         body: jsonEncodeData,
//         headers: headers,
//         encoding: Encoding.getByName("utf-8"),
//       );
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       // Map userMap = jsonDecode(response.body);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// put file upload api call common handler
//   Future<dynamic> putFileUploadApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//       Map<String, String> headers = await GlobalServices.getHeaders();
//
//       /// print request data
//       Logger.printLog(
//           tag: 'PUT FILE UPLOAD METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       var response = await http.put(url, body: File(data![ApiKey.uploadFilePath]).readAsBytesSync(), headers: headers);
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// put file upload api call common handler
//   Future<dynamic> putFileFormDataUploadApiRequest(var url,
//       {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = 'multipart/form-data';
//
//       /// print request data
//       Logger.printLog(
//           tag: 'PUT FILE UPLOAD METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       var uri = Uri.parse(url);
//       var request = http.MultipartRequest('PUT', uri);
//       request.headers.addAll(headers);
//
//       ///provide file key here first!!!
//       // request.files.add(await http.MultipartFile.fromPath(
//       //   ApiKey.file,
//       //   data![ApiKey.uploadFilePath],
//       // ));
//
//       var response = await request.send();
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       // var response = await http.put(url, body: File(data[ApiKey.uploadFilePath]).readAsBytesSync(), headers: headers);
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.statusCode.toString(), logIcon: Logger.cloud);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.statusCode.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.statusCode.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// post file upload api call common handler using Dio
//   Future<dynamic> postFileFormDataUploadApiRequest(var url,
//       {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         // // Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//         const Loader();
//       }
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers['Content-Type'] = 'multipart/form-data';
//
//       /// print request data
//       Logger.printLog(
//           tag: 'POST FILE UPLOAD METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       var formData = dio.FormData.fromMap(data!);
//
//       var response = await dio.Dio(dio.BaseOptions(validateStatus: (_) => true, headers: headers))
//           .post(url,
//               data: formData,
//               options: dio.Options(
//                 headers: headers,
//               ))
//           .catchError((onError) {
//         print(onError);
//       });
//
//       print(response);
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.data.toString(), logIcon: Logger.cloud);
//
//       if (response.statusCode! >= 100 && response.statusCode! <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.statusCode.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode! >= 200 && response.statusCode! <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.statusCode.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode! >= 300 && response.statusCode! <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       } else if (response.statusCode! >= 400 && response.statusCode! <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, stringData: response.data.toString());
//       } else if (response.statusCode! >= 500 && response.statusCode! <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.statusCode.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode}');
//         return ApiResponseModel(code: response.statusCode);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// get api call common handler
//   Future<dynamic> getApiRequest(var url, {Map<String, dynamic>? data, bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         Get.dialog(LoadingProgressBar(isDisMissile: true), barrierDismissible: false);
//       }
//       Map<String, String> headers = await GlobalServices.getHeaders();
//
//       /// print request data
//       Logger.printLog(
//           tag: 'GET METHOD \n\n REQUEST_URL :',
//           printLog:
//               '\n $url?${Uri(queryParameters: data).query} \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       /// call api [get api with queryParameters e.g https://www.google.com/getProfile?userId=123456]
//       var response = await http.get(
//         Uri.parse('$url?${Uri(queryParameters: data).query}'),
//         headers: headers,
//       ) /*
//           .onError((error, stackTrace) {
//         Logger.printLog(tag: 'RESPONSE_DATA :', printLog: '${error.toString()} \n\n $stackTrace', logIcon: Logger.error);
//       }).whenComplete(() {
//         Logger.printLog(tag: 'whenComplete :', printLog: 'COMPLETED', logIcon: Logger.cloud);
//       }).timeout(const Duration(seconds: 2000), onTimeout: () {
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: 'Request time out', logIcon: Logger.error);
//         EasyLoading.showError('REQUEST TIME OUT PLEASE TRY AGAIN!');
//       })*/
//           ;
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
//
//   /// delete api call common handler
//   Future<dynamic> deleteApiRequest(var url,
//       {Map<String, dynamic>? data,
//       String contentType = 'application/json; charset=utf-8',
//       bool isShowLoader = true}) async {
//     try {
//       if (isShowLoader) {
//         /// show custom progress dialog
//         //showDialogs(Popups(statement: "Loading"));
//
//         /// show progress dialog
//         Get.dialog(LoadingProgressBar(), barrierDismissible: false);
//       }
//
//       Map<String, String> headers = await GlobalServices.getHeaders();
//       headers["Content-Type"] = contentType;
//
//       /// print request data
//       Logger.printLog(
//           tag: 'PUT METHOD \n\n REQUEST_URL :',
//           printLog: '\n $url \n\n REQUEST_HEADER : ${headers.toString()}  \n\n REQUEST_DATA : ${data.toString()}',
//           logIcon: Logger.info);
//
//       /// call api
//       http.Response response = await http.delete(
//         url,
//         body: jsonEncode(data),
//         headers: headers,
//         // encoding: Encoding.getByName("utf-8"),
//       );
//
//       if (isShowLoader) {
//         /// dismiss custom progress dialog
//         // dismissDialogs();
//
//         /// dismiss progress dialog
//         Get.back();
//       }
//
//       Logger.printLog(tag: 'RESPONSE_DATA :', printLog: response.body.toString(), logIcon: Logger.cloud);
//
//       // Map userMap = jsonDecode(response.body);
//
//       if (response.statusCode >= 100 && response.statusCode <= 199) {
//         /// Informational responses (100–199)
//         Logger.printLog(tag: 'CODE 100 TO 199 : ', printLog: response.body.toString(), logIcon: Logger.warning);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 200 && response.statusCode <= 299) {
//         /// Successful responses (200–299)
//         Logger.printLog(tag: 'CODE 200 TO 299 : ', printLog: response.body.toString(), logIcon: Logger.success);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 300 && response.statusCode <= 399) {
//         /// Redirects (300–399)
//         Logger.printLog(tag: 'CODE 300 TO 399 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 400 && response.statusCode <= 499) {
//         /// Client errors (400–499)
//         Logger.printLog(tag: 'CODE 400 TO 499 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else if (response.statusCode >= 500 && response.statusCode <= 599) {
//         /// Server errors (500–599)
//         Logger.printLog(tag: 'CODE 500 TO 599 : ', printLog: response.body.toString(), logIcon: Logger.error);
//         return ApiResponseModel(code: response.statusCode, data: response);
//       } else {
//         /// Other error's
//         Logger.printLog(tag: 'OTHER : ', printLog: response.body.toString(), logIcon: Logger.error);
//         // Toast.errorMessage('CODE : ${response.statusCode} \nMESSAGE : ${response.body}');
//         return ApiResponseModel(code: response.statusCode, data: response);
//       }
//     } on TimeoutException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.serverTakingLong;
//       networkError = e;
//     } on SocketException catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.internetConnectionProblem.tr;
//       networkError = e;
//     } on Error catch (e) {
//       isNetworkError = true;
//       networkErrorMessage = ConstKeys.somethingWentWrong;
//       networkError = e;
//     }
//     if (isNetworkError) {
//       Logger.printLog(
//           tag: 'NETWORK_ERROR :',
//           printLog: '$networkErrorMessage ${networkError == null ? "" : ('\n\n $networkError')}',
//           logIcon: Logger.info);
//       // Toast.errorMessage('$networkErrorMessage');
//     }
//   }
// }
