import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/widgets/custom_text_form_field.dart';

class UploadMovieDialog extends StatefulWidget {
  const UploadMovieDialog({Key? key}) : super(key: key);
  @override
  State<UploadMovieDialog> createState() => _UploadMovieDialogState();
}

class _UploadMovieDialogState extends State<UploadMovieDialog> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String title = '';
    DateTime openDate = DateTime.now();
    String imageUrl = '';
    String director = '';
    List actors = [];
    int length = 0;
    String grade = '전체관람가';

    return AlertDialog(
      title: Form(
        child: Container(
          width: 600,
          child: Column(
            children: [
              Text('영화정보'),
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
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: kGreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                     DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 1),
                      maxTime: DateTime(2023, 12, 31),
                      onConfirm: (DateTime date) {
                        setState(() {
                          openDate = date;
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.ko,
                    );
                  },
                  child: Text(
                    '날짜선택',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
