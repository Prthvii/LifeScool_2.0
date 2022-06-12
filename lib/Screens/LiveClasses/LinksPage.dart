import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class LinksPage extends StatefulWidget {
  final data;
  LinksPage({this.data});

  @override
  _LinksPageState createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {

  @override
  Widget build(BuildContext context) {
    print("widget.data");
    print(widget.data);

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
              "Links",
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
        FlutterWebBrowser.openWebPage(
          url:  item['itemData']['url'].toString(),
          customTabsOptions: CustomTabsOptions(
            colorScheme: CustomTabsColorScheme.dark,
            toolbarColor: themeOrange,
            secondaryToolbarColor: Colors.green,
            navigationBarColor: imgBgClr,
            addDefaultShareMenuItem: false,
            instantAppsEnabled: false,
            showTitle: true,
            urlBarHidingEnabled: false,
          ),
          safariVCOptions: SafariViewControllerOptions(
            barCollapsingEnabled: true,
            preferredBarTintColor: Colors.green,
            preferredControlTintColor: Colors.amber,
            dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
            modalPresentationCapturesStatusBarAppearance: true,
          ),
        );
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
              Image.asset("assets/Icons/linksIcon.png", height: 20, width: 20)
            ],
          ),
        ),
        // child: ,
      ),
    );
  }
}
