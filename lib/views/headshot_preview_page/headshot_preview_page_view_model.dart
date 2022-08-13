import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:group_chat/core/base/base_view_model.dart';
import 'package:group_chat/core/locator.dart';
import 'package:group_chat/core/services/navigator_service.dart';
import 'package:group_chat/other/apireturn.dart';
import 'package:group_chat/other/auth.dart';
import 'package:group_chat/other/config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class HeadshotPreviewPageViewModel extends BaseViewModel {
  HeadshotPreviewPageViewModel();
  final ImagePicker picker = ImagePicker();
  final uploader = FlutterUploader();
  bool is_pick_dialog = false;
  Future openImagePicker(context) async {
    bool is_upload_dialog = false;

    final directory = await getApplicationDocumentsDirectory();
    final XFile image = await picker.pickImage(source: ImageSource.gallery);
    String filePath = '${directory.path}/${image.name}';
    Logger().i(filePath);

    showDialog(
        context: context,
        builder: (context) => UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
                width: 150,
                child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [CircularProgressIndicator(), Text('檔案上傳中')],
                      ),
                    )))),
        barrierDismissible: false);
    is_upload_dialog = true;
    await image.saveTo(filePath);
    final taskId = await uploader.enqueue(
        url: Config.apiURL(
            '/file/image/headshot/upload'), //required: url to upload to
        files: [
          FileItem(
              filename: image.name, savedDir: directory.path, fieldname: "file")
        ], // required: list of files that you want to upload
        method: UploadMethod.POST, // HTTP method  (POST or PUT or PATCH)
        headers: {},
        data: {
          "id": Authentication.user.id
        }, // any data you want to send in upload request
        showNotification:
            true, // send local notification (android only) for upload status
        tag: "upload 1"); // unique tag for upload task
    // uploader.progress.listen((progress) {
    //   //... code to handle progress
    //   if (progress.taskId == taskId) {
    //     Logger().d(progress.status);
    //   }
    // });
    Logger().d(taskId);
    // ignore: cancel_subscriptions
    final a = uploader.result.listen((result) {
      if (result.taskId == taskId) {
        Logger().d(result.statusCode);
        if (result.statusCode == 200) {
          if (is_upload_dialog) {
            locator<NavigatorService>().pop(context);
            is_upload_dialog = false;
          }
          if (is_pick_dialog) {
            locator<NavigatorService>().pop(context);
            is_pick_dialog = false;
          }
          APIReturn response = APIReturn.fromMap(jsonDecode(result.response));
          Authentication.user.image = response.data['filename'];
          notifyListeners();
        }
      }

      //... code to handle result
    }, onError: (ex, stacktrace) {
      // ... code to handle error
      if (is_upload_dialog) {
        locator<NavigatorService>().pop(context);
        is_upload_dialog = false;
      }
      //
      Logger().e(ex);
      Logger().e(stacktrace);
    });
  }
  // Add ViewModel specific code here
}
