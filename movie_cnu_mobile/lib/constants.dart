import 'package:flutter/material.dart';

const Color kWhiteColor = Color(0xFFFAFAFA);
const Color kBlackColor = Color(0xFF000000);
const Color kDeepBlueColor = Color(0xFF1D4EFF);
const Color kBlueColor = Color(0xFF51B6FF);
const Color kGreyColor = Color(0xFF979797);
const Color kDarkGreyColor = Color(0xFF696969);
const Color kLightGreyColor = Color(0xFFF2F2F8);
const Color kRedColor = Color(0xFFFF0000);
const Color kYellowColor = Color(0xFFFFB800);
const Color kPinkColor = Color(0xFFFF7878);
const Color kGreenColor = Color(0xFF81C147);
const Color kShimmerColor = Color(0x80979797);
const Color kPurpleColor = Color(0xFFBA55D3);
const Color kMainColor = Color(0xFF07BBBB);
const Color kSplashBackgroundColor = Color(0xFFFAFAFA);

final List kGradeList = [
  '전체관람가',
  '만12세이상 관람가',
  '만15세이상 관람가',
  '만18세이상 관람가',
  '청소년관람불가'
];

final List kTheaterList = [
  {
    'id':'movie1',
    'name':'IMAX1'
  },
  {
    'id':'movie2',
    'name':'IMAX2'
  },
  {
    'id':'movie3',
    'name':'IMAX3'
  },
  {
    'id':'movie4',
    'name':'IMAX4'
  },
  {
    'id':'movie5',
    'name':'IMAX5'
  },
];
const noImageUrl =
    'https://image.mfa.go.th/mfa/r_0x740/bE5KohkHoq/migrate_directory/news-20190103-152039.jpg';

RegExp kEmailRegExp = RegExp(
    r'[0-9a-z]([\-.\w]*[0-9a-z\-_+])*@([0-9a-z][\-\w]*[0-9a-z]\.)+[a-z]{2,9}');
