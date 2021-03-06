import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:movie_cnu_web/widgets/select_grade_bottom_sheet.dart';
import 'package:uuid/uuid.dart';
import '../constants.dart';
import '../controllers/movie_controller.dart';
import '../widgets/custom_text_form_field.dart';

class UploadMovieScreen extends StatefulWidget {
  const UploadMovieScreen({Key? key}) : super(key: key);

  @override
  State<UploadMovieScreen> createState() => _UploadMovieScreenState();
}

class _UploadMovieScreenState extends State<UploadMovieScreen> {
  final formKey = GlobalKey<FormState>();

  String movieId = const Uuid().v4();
  String title = '';
  DateTime openDate = DateTime.now();
  Uint8List? fileBytes;
  String director = '';
  List actors = [];
  int length = 0;
  String grade = '전체관람가';

  void uploadPressed() async{
    if (formKey.currentState!.validate() ) {
      formKey.currentState!.save();
      Map<String, dynamic> movieData = {
        'id': movieId,
        'title': title,
        'openDate': openDate.toString(),
        'director': director,
        'actors': actors,
        'length': length,
        'grade': grade,
      };
      bool uploadSuccess = await MovieController.to.uploadMovie(movieId, movieData);
      if(uploadSuccess){
        print('upload Movie Success about ${movieData.toString()}');
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '영화정보',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomTextFormField(
              label: '영화제목',
              onSaved: (value) {
                title = value;
              },
              validator: (value) {
                if (value == null) return '영화제목을 입력해주세요!';
                if (value.length < 2) return '2글자이상 입력해주세요!';
                return null;
              },
            ),
            CustomTextFormField(
              label: '영화감독',
              onSaved: (value) {
                director = value;
              },
              validator: (value) {
                if (value == null) return '영화감독을 입력해주세요!';
                if (value.length < 2) return '2글자이상 입력해주세요!';
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: kGreyColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () => DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2022, 1, 1),
                  maxTime: DateTime(2023, 12, 31),
                  onConfirm: (DateTime date) {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        openDate = date;
                      });
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.ko,
                ),
                child: Row(
                  children: [
                    Text(
                      '개봉일 : ${openDate.year}년 ${openDate.month}월 ${openDate.day}일',
                      style: const TextStyle(color: kBlackColor),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextFormField(
              label: '영화배우',
              onSaved: (value) {
                actors = value.split(',');
              },
              validator: (value) {
                if (value == null || value.length < 1) return '영화배우를 입력해주세요!';
                return null;
              },
            ),
            CustomTextFormField(
              label: '영화길이',
              onSaved: (value) {
                length =int.parse(value);
              },
              inputType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '영화길이를 입력해주세요!';
                }
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: kGreyColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () async {
                  String? result = await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const SizedBox(
                        height: 200,
                        child: SelectGradeBottomSheet(),
                      );
                    },
                  );
                  if (result != null) {
                    setState(() {
                      grade = result;
                    });
                  }
                },
                child: Row(
                  children: [
                    Text(
                      '관람등급 : $grade',
                      style: const TextStyle(color: kBlackColor),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => uploadPressed(),
                    child: const Text('영화 등록하기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
