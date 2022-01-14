import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class yourQueries extends StatelessWidget {
  // const yourQueries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your queries", style: bold14),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Queries(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Queries(int index) {
    return Wrap(
      runSpacing: 10,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Can't find bounding box",
          style: txt14Semi,
        ),
        Text(
          "I can't find the selection box now. It was using it before saving, but cant seem to find it now. Please help",
          style: txt14,
        ),
        Text(
          "Just Now",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
