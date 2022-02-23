import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class liveBatchesBriefPage extends StatefulWidget {
  const liveBatchesBriefPage({Key key}) : super(key: key);

  @override
  _liveBatchesBriefPageState createState() => _liveBatchesBriefPageState();
}

class _liveBatchesBriefPageState extends State<liveBatchesBriefPage> {
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
                  backgroundColor: lifescool_highlight,
                ),
              ),
            ),
            w(16),
            Text(
              "Live Batch Brief",
              style: size16_700Mallu,
            )
          ],
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        height: 76,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: (Colors.grey[300]),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(-1, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                "Application open for batch",
                style: size14_400Blue,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  applyBottomSheet();
                },
                child: Container(
                  height: 43,
                  width: 103,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: gradientHOME,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Apply now",
                      style: size14_700W,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  applyBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  h(20),
                  Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  h(20),
                  Text(
                    "Slot selection",
                    style: size16_700Red,
                  ),
                  h(8),
                  Text(
                    "Choose an available slot for the classes",
                    style: size16_400Blue,
                  ),
                  h(16),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return timeSlotsList(index);
                    },
                  ),
                  h(16),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 43,
                        width: 103,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: disableGrey,
                            // gradient: gradientHOME,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Proceed",
                            style: size14_700Grey,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top: 16),
                  ),
                ],
              ),
            ));
  }

  timeSlotsList(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: liteRed),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: RichText(
          softWrap: true,
          text: TextSpan(children: [
            TextSpan(
              text: '8AM',
              style: size16_700Red,
            ),
            TextSpan(
              text: ' to ',
              style: size16_400Red,
            ),
            TextSpan(
              text: '10AM',
              style: size16_700Red,
            ),
            TextSpan(
              text: ' four days a week',
              style: size16_400Red,
            ),
          ]),
        ),
      ),
    );
  }
}
