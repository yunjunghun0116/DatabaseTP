import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:movie_cnu_mobile/constants.dart';

import '../widgets/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchTitle = '';
  DateTime? searchDate;

  final formKey = GlobalKey<FormState>();

  void searchPressed() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (searchTitle.isNotEmpty && searchDate == null) {
        return;
      }
      if (searchTitle.isEmpty && searchDate != null) {
        return;
      }
      if (searchTitle.isNotEmpty && searchDate != null) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: const Text('검색'),
        actions: [
          TextButton(
            onPressed: () => searchPressed(),
            child: const Text('검색하기'),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: '영화제목',
              onSaved: (value) {
                searchTitle = value;
              },
              inputType: TextInputType.emailAddress,
              validator: (value) {
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    '영화관람예정일 : ',
                    style: TextStyle(color: kGreyColor),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2022, 6, 1),
                          maxTime: DateTime(2022, 12, 31),
                          onConfirm: (DateTime date) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              setState(() {
                                searchDate = date;
                              });
                            });
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.ko,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: kGreyColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: searchDate != null
                            ? Text(searchDate.toString().substring(0, 10))
                            : const Text(''),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
