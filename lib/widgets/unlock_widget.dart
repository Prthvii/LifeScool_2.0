import 'package:flutter/material.dart';
import 'package:lifescool/Const/Constants.dart';

class UnlockWidget extends StatelessWidget {
  // const UnlockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: AssetImage(
            "assets/images/gg.png",
          ),
          fit: BoxFit.fitWidth,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "To access the full course, please purchase",
                style: bold14,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Text(
                  "Unlock now for ₹999",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
