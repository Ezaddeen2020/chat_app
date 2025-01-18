import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:chatapp/core/classes/status_request.dart';
import 'package:chatapp/core/functions/check_internet.dart';
import 'package:chatapp/links_api.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class Crud {
//==========================   GET   ===============================//

  Future<Either<StatusRequest, Map<String, dynamic>>> getData(String linkurl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkurl));
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfauiler);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      log('Error: $e');
      return const Left(StatusRequest.offlinefailure);
    }
  }

//==========================   POST   ===============================//

  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
      String linkurl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkurl),
          headers: AppLinks.headersList,
          body: jsonEncode(data), // must be JSON encoding
        );

        log(response.body);

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfauiler);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      log('Error: $e');
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataFiles(String linkurl, Map data,
      {List<File>? files}) async {
    try {
      if (await checkInternet()) {
        var request = http.MultipartRequest('POST', Uri.parse(linkurl));
        request.headers.addAll(AppLinks.headersList);

        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        if (files != null) {
          files.forEach(
            (element) async {
              request.files.add(await http.MultipartFile.fromPath('files', element.path));
            },
          );
        }

        var res = await request.send();
        final resBody = await res.stream.bytesToString();
        log(resBody);
        if (res.statusCode == 200 || res.statusCode == 201) {
          Map responsebody = jsonDecode(resBody);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.offlinefailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      log('Error: $e');
      return const Left(StatusRequest.offlinefailure);
    }
  }

//   Future<Either<StatusRequest, Map<String, dynamic>>> postDataUnified(
//     String linkurl,
//     Map<String, dynamic> data,
//     {List<File>? files}) async {

//   try {
//     if (await checkInternet()) {
//       // إذا كانت هناك ملفات مرفقة، استخدم MultipartRequest
//       if (files != null && files.isNotEmpty) {
//         var request = http.MultipartRequest('POST', Uri.parse(linkurl));
//         request.headers.addAll(AppLinks.headersList);

//         data.forEach((key, value) {
//           request.fields[key] = value.toString();
//         });

//         // إضافة الملفات المرفقة
//         for (var element in files) {
//           request.files.add(await http.MultipartFile.fromPath('files', element.path));
//         }

//         var res = await request.send();
//         final resBody = await res.stream.bytesToString();
//         log(resBody);

//         if (res.statusCode == 200 || res.statusCode == 201) {
//           Map responsebody = jsonDecode(resBody);
//           return Right(responsebody);
//         } else {
//           return const Left(StatusRequest.serverfauiler);
//         }
//       } else {
//         // إذا لم تكن هناك ملفات مرفقة، استخدم http.post
//         var response = await http.post(
//           Uri.parse(linkurl),
//           headers: AppLinks.headersList,
//           body: jsonEncode(data), // تأكد من أن البيانات يتم ترميزها إلى JSON
//         );

//         log(response.body);

//         if (response.statusCode == 200 || response.statusCode == 201) {
//           Map<String, dynamic> responseBody = jsonDecode(response.body);
//           return Right(responseBody);
//         } else {
//           return const Left(StatusRequest.serverfauiler);
//         }
//       }
//     } else {
//       return const Left(StatusRequest.offlinefailure);
//     }
//   } catch (e) {
//     log('Error: $e');
//     return const Left(StatusRequest.offlinefailure);
//   }
// }
}
