import 'dart:ui';

import 'package:flutter/material.dart';

final testImg =
    "https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg?size=626&ext=jpg";
final wrkImg = "https://miro.medium.com/max/1200/0*YTO7ijHD5_selMfZ.jpg";
final bold16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);
final Reg16 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  fontFamily: 'Nunito',
);
final Reg10 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: 'Nunito',
);
final bold16blue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xff4236F1),
    fontFamily: 'Nunito');
final bold16DarkBlue = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xff2F455C));
final bold16G = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.green,
  fontFamily: 'Nunito',
);
final bold20 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
final bold12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);
final bold14 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);
final txt16White = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
final txt16Gry = TextStyle(
  fontSize: 16,
  color: Colors.grey,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
final txt14Gry = TextStyle(
  fontSize: 16,
  color: Colors.grey,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
final txt16 = TextStyle(
  fontSize: 16,
);
final txt16Selct = TextStyle(
  fontSize: 16,
  color: Colors.green,
  fontFamily: 'Nunito',
);
final txt14Selct = TextStyle(
  fontSize: 14,
  color: Colors.green,
  fontFamily: 'Nunito',
);
final txt20 = TextStyle(fontSize: 20);
final txt15 = TextStyle(fontSize: 12);
final txt12 = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
final txt12Bd = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);
final txt14Semi = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Nunito',
);

final size16_700Mallu = TextStyle(
    fontSize: 16,
    fontFamily: 'Mallu',
    fontWeight: FontWeight.w700,
    color: darkBlue);

final txt14SemiWhite = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontFamily: 'Nunito',
);
final txt16Semi = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
final txt16_700Orng = TextStyle(
  fontSize: 16,
  color: themeOrange,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final txt12_400 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontFamily: 'Nunito',
);
final size14_600W = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontFamily: 'Nunito',
);
final size14_600grey = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Color(0xff6D6D6D),
  fontFamily: 'Nunito',
);
final txt14 = TextStyle(
  fontSize: 14,
);
final appBarTxtStyl = TextStyle(
  color: Colors.black,
  fontSize: 22,
  fontWeight: FontWeight.w600,
  fontFamily: 'Nunito',
);
final size14_700Red = TextStyle(
  color: themeOrange,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final size14_700White = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final size14_700Grey = TextStyle(
  color: Color(0xff6D6D6D),
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);

final size14_700 = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final size14_700Blue = TextStyle(
  color: lifescoolBlue,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final size14_400 = TextStyle(
  color: Colors.black,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'Nunito',
);
final size14_400Blue = TextStyle(
  color: lifescoolBlue,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: 'Nunito',
);
final size14_400G = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff3E3E3E));
final size16_400 = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: 'Nunito',
);
final size14_700W = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w700,
  fontFamily: 'Nunito',
);
final darkBlue = Color(0xff2F455C);
final shadw = BoxShadow(
  color: Colors.black12,
  spreadRadius: 0.5,
  blurRadius: 0.5,
  offset: Offset(0, 0),
);
final themeOrange = Color(0xffFD5C36);
final gradientTopBottom = LinearGradient(
  colors: [
    Color(0xffFBA33A),
    Color(0xffFD5C36),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
final gradientLeftRyt = LinearGradient(
  colors: [
    Color(0xffFD5C36),
    Color(0xffFBA33A),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
final gradientRed = LinearGradient(
  colors: [
    Color(0xffFFE1E1),
    Colors.white,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final gradientGreen = LinearGradient(
  colors: [
    Color(0xffEAFCE9),
    Colors.white,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
final gradientslope = LinearGradient(
  colors: [
    Color(0xffFD5C36),
    Color(0xffFBA33A),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
final gradientHOME = LinearGradient(
  colors: [
    Color(0xffF7993A),
    Color(0xffFD5C36),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final DarkBlue = Color(0xff110C10);
final greyBG = Color(0xffE9E9E9);
final greyClr = Color(0xffF6F6F6);
final grey2 = Color(0xffE6E6E6);
final green = Color(0xff38C258);
final lifescoolBlue = Color(0xff2E455C);
final lifescool_highlight = Color(0xffFEE9E4);

final profileToptxt = TextStyle(
  color: Color(0xffFFF7AF),
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontFamily: 'Nunito',
);

final blckClr = Color(0xff2F455C);

w(double w) {
  return SizedBox(width: w);
}

h(double w) {
  return SizedBox(height: w);
}

final liteRed = Color(0xffFFF4F1);
final selectedRed = Color(0xffEA9985);
