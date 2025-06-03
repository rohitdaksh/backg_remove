import 'dart:convert';
import 'package:backg_remove/constants/api_url.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class HomeController {
  final ImagePicker? imagePicker = ImagePicker();

  Future<Uint8List?> pickImage() async {
    try {
      XFile? image = await imagePicker!.pickImage(source: ImageSource.gallery);

      if (image == null) {
        return null;
      }
      Uint8List imageBytes = await image.readAsBytes();
      return imageBytes;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Uint8List?> removeBackGround(Uint8List imageBytes) async {

    try {
      String base64 = base64Encode(imageBytes);

        Uri uri = Uri.parse(MyApi.removeBgApi);
        Response response = await post(
          uri,
          headers: {'X-API-key' : MyApi.apiKey},
          body: {'image_file_b64': base64}
        );

        if(response.statusCode == 200){
           Uint8List image = response.bodyBytes;
           return image;
        }else if(response.statusCode == 400){
          debugPrint('Invalid parameters or input file unprocessaable');
          return null;
        }else if(response.statusCode == 402){
          debugPrint('Insufficient credits');
          return null;
        }else if(response.statusCode == 403){
          debugPrint('Authentication failed');
          return null;
        }else{
          debugPrint('Status code is ${response.statusCode}');
          return null;
        }

    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
