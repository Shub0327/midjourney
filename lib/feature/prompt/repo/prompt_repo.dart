import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PromptRepo {
  static Future<File?> generateImage(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-8OF0AMRDdp3k5eWF0d22GXjPBvDRaFgzIln2gFuISBgDnRz'
      };
      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '122',
        'aspect_ratio': '1:1',
        'cfg': '1',
        'seed': '1',
        'high_res_results': '1'
      };

      Dio dio = Dio();
      dio.options = BaseOptions(headers: headers);
      Response response = await dio.post(url, data: payload);
      if (response.statusCode == 200) {
        File file = File("image.jpg");
        file.writeAsBytesSync(response.data);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
