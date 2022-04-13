import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';
import 'package:lifescool/Shorts/Data/triggerReels.dart';
import 'package:lifescool/Shorts/ShortVideoPage.dart';

class SavedShorts extends StatefulWidget {


  @override
  _SavedShortsState createState() => _SavedShortsState();
}

class _SavedShortsState extends State<SavedShorts> {


  var arrSaved = [];

  var userName = "";
  var isLoading = true;


  @override
  void initState() {
    super.initState();

    print("xoxoxo");
    this.getData();


    setState(() {});
  }

  Future<String> getData() async {
    setState(() {
      isLoading = true;
    });


    var rsp = await triggerReelsApi("SAVEDSHORTSLIST","");
    print("searchhhhhhhh");
    print(rsp);

    if (rsp['attributes']['message'].toString() == "Success") {
      setState(() {
        arrSaved = rsp['attributes']['triggerdata'][0]['savedshorts'];

      });

    }

    setState(() {
      isLoading = false;
    });
    return "0";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: lifescool_highlight,
                radius: 22,
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            w(12),
            Text("Saved Shorts", style: size14_700),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          interactive: true,
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 90 / 158),
            itemCount: arrSaved != null ? arrSaved.length : 0,
            itemBuilder: (context, index) {
              final item = arrSaved != null ? arrSaved[index] : null;
              return Item(item,index);
            },
          ),
        ),
      ),
    );
  }

  Item(var item,int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => MyLearningNew()),
              builder: (context) => ShortsPlayerPage(
                highligts: item,
              )),
        );
      },
      child: Container(
        width: 90,
        height: 158,
        color: themeOrange,
        child: Image.network(
          item['thumbnail_url'].toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
