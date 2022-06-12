import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lifescool/Helper/snackbar_toast_helper.dart';
class DownloadsPage extends StatefulWidget {
  final data;
  DownloadsPage({this.data});
  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      showToastSuccess("Downloading...");
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: '/storage/emulated/0/Download/',
        showNotification: true,
        openFileFromNotification: true,
      );
      print("downdload");
      print(id);
      showToastSuccess("Downloaded!");
    } else {
      print('Permission Denied');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  radius: 24,
                  backgroundColor: grey2,
                ),
              ),
            ),
            w(16),
            Text(
              "Downloads",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(height: 8),
          shrinkWrap: true,
          itemCount:
          widget.data != null ? widget.data.length : 0,
          itemBuilder: (context, index) {
            final item = widget.data != null
                ? widget.data[index]
                : null;
            return list(item,index);
          },
        ),
      ),
    );
  }

  list(var item,int index) {
    return GestureDetector(
      onTap: (){
        _download( item['itemData']['url'].toString());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyClr,
            border: Border.all(color: grey2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          child: Row(
            children: [
              Text((index+1).toString()+". "+item['itemName'].toString(), style: size14_400),
              Spacer(),
              Image.asset("assets/Icons/downloadIcons.png", height: 20, width: 20)
            ],
          ),
        ),
        // child: ,
      ),
    );
  }
}
