import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle mainheading=TextStyle(
  fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
  fontWeight: FontWeight.w700,
  color: Colors.blue,
);

TextStyle heading=TextStyle(
  fontSize: ScreenUtil().setSp(23, allowFontScalingSelf: true),
);

TextStyle heading2=TextStyle(
  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
);

TextStyle heading3=TextStyle(
  fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
  fontWeight: FontWeight.w500,
  color:Colors.grey[700],
);

TextStyle subheading=TextStyle(
  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
  fontWeight: FontWeight.w600,
  color:Colors.grey[600],
);