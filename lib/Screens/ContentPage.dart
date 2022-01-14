import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(ss.height * 0.03),
      child: Column(
        children: [
          Text(
            "Course Content",
            style: TextStyle(
                color: Color(0xffFC4834),
                fontSize: ss.height * 0.033,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: ss.height * 0.04,
          ),
          CourseContent(),
          SizedBox(
            height: ss.height * 0.05,
          ),
          LiveProjects(),
          SizedBox(
            height: ss.height * 0.05,
          ),
          Assesment(),
          SizedBox(
            height: ss.height * 0.05,
          ),
          Button2()
        ],
      ),
    );
  }

  easy(
    String img,
    String txt,
  ) {
    final ss = MediaQuery.of(context).size;
    return Row(
      children: [
        Image.asset(
          img,
          width: ss.width * 0.05,
        ),
        SizedBox(
          width: ss.width * 0.03,
        ),
        Expanded(
          child: Text(
            txt,
            style: TextStyle(
                fontSize: ss.height * 0.022,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  CourseContent() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xffFBF8EF)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            head("1. Basics of Embroidery"),
            point(
                "Our Embroidery expert takes us step by step through the basics of stitching involved in embroidery along with explaining what kind of tools and equipment one needs to use. 10 popular embroidery stitches are illustrated in this module."),
            SizedBox(
              height: ss.height * 0.01,
            ),
            point(
              "1.1.Knowing your equipments and introduction to 2 basic stitches",
            ),
            point("1.2 How to do Stem stitch"),
            point("1.3 Chain stitch and Split Stitch "),
            point("1.4 French Knot and Lazy Daisy "),
            point("1.5 Button hole ,Satin and Cross stitch"),
            head("2. Floral and Leaf Embroidery"),
            point(
                "In this module you will learn to create leaf and floral patterns in embroidery along with learning 6 different methods to stitch alphabets using embroidery calligraphy."),
            SizedBox(
              height: ss.height * 0.01,
            ),
            point("2.1 Creating floral patterns : woven rose and lazy daisy"),
            point("2.2 Floral pattern: french knot"),
            point("2.2 Floral pattern: french knot"),
            point("2.4 Bullion Knot Rose"),
            point("2.5 Creating Leaf patterns:lazy daisy and satin stitch"),
            point("2.6 Fish bone stitch"),
            point(
                "2.7 Embroidery Calligraphy: How to write alphabets using your needle"),
            point(
                "2.8 Embroidery Calligraphy using chain stitch and split stitch"),
            point(
                "2.9 Calligraphy by satin stitch, back stitch, brick stitch and whipped back stitch"),
            head("3. Hair Embroidery"),
            point(
                "The module on hair embroidery touches upon 6 varieties of hair styles that one can weave using their embroidery kit over a design in an easy DIY method"),
            SizedBox(
              height: ss.height * 0.01,
            ),
            point("3.1 six different types of hair stitching"),
            point("3.2 straight hair and curly hair"),
            point("3.3 ponytail and braided hair stitching"),
            head("4. Portrait Embroidery"),
            point(
                "In this module you will learn the right tools and techniques to create a portrait design , even without knowing how to draw, and how to create a 3D embroidered portrait design."),
            SizedBox(
              height: ss.height * 0.01,
            ),
            point(" 4.1 Using your smartphone for smart designing"),
            point(" 4.2 Printing Method for portrait design"),
            point(" 4.3 Portrait Embroidery using app based design"),
            head("5. How to run a home-based embroidery business"),
            point(
                'The final module touches upon industry proven hacks about running an embroidery business and what to keep in mind when selling customized products. '),
            point("5.1 How to calculate rates for custom embroidery"),
            point(" 5.2 Things to keep in mind as an embroidery entrepreneur."),
            SizedBox(
              height: ss.height * 0.01,
            ),
            point("*Bonus Lessons to respond to your doubts")
          ],
        ),
      ),
    );
  }

  head(String txt) {
    final ss = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: ss.height * 0.04,
        bottom: ss.height * 0.01,
      ),
      child: Text(
        txt,
        style: TextStyle(
            color: Color(0xffFC4834),
            fontSize: ss.height * 0.033,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  point(String txt) {
    final ss = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: ss.width * 0.05),
      child: Text(
        txt,
        style: TextStyle(
            fontSize: ss.height * 0.023,
            fontWeight: FontWeight.w500,
            color: Color(0xff2F455C)),
      ),
    );
  }

  LiveProjects() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: ss.width * 0.89,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Color(0xff2F455C)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Wrap(
          runSpacing: ss.height * 0.03,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Live projects",
              style: TextStyle(
                  fontSize: ss.height * 0.027,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: [
                Expanded(
                  child: easy(
                    "assets/Icons/emoji.png",
                    "Hoop Magic: stitching your 3D self portrait",
                  ),
                ),
                SizedBox(
                  width: ss.width * 0.1,
                ),
                Expanded(
                  child: easy(
                    "assets/Icons/napkin.png",
                    "Creating a custom design napkin",
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: easy(
                    "assets/Icons/face.png",
                    "Hair Magic: stitch your model’s face in 3D",
                  ),
                ),
                SizedBox(
                  width: ss.width * 0.1,
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }

  Assesment() {
    final ss = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Color(0xff0D917B),
              Color(0xff1FC578),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Wrap(
          runSpacing: ss.height * 0.03,
          alignment: WrapAlignment.center,
          children: [
            Text(
              "Course Requirements",
              style: TextStyle(
                  fontSize: ss.height * 0.027,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: ss.width * 0.03,
                ),
                SizedBox(
                  width: ss.width * 0.05,
                ),
                Expanded(
                  child: Text(
                    "Pop up quiz after every module to test your knowledge ",
                    style: TextStyle(
                        fontSize: ss.height * 0.022,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: ss.width * 0.03,
                ),
                SizedBox(
                  width: ss.width * 0.05,
                ),
                Expanded(
                  child: Text(
                    "Final Assessment",
                    style: TextStyle(
                        fontSize: ss.height * 0.022,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Button2() {
    final ss = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xffE9E9E9), borderRadius: BorderRadius.circular(11)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ss.height * 0.022),
        child: Text(
          "Explore Course Brief",
          style: TextStyle(
              fontSize: ss.height * 0.027,
              fontWeight: FontWeight.bold,
              color: Color(0xffFC4834)),
        ),
      ),
    );
  }
}
