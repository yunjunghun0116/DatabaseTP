import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/movie_controller.dart';
import 'package:movie_cnu_mobile/screens/search_result_screen.dart';

import '../models/movie.dart';
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

  void searchPressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (searchTitle.isEmpty && searchDate == null) {
        await showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    '검색하고자 하는 영화제목이나\n영화관람 예정일을 입력해주세요!!!',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            });
        return;
      }
      if (searchTitle.isNotEmpty && searchDate == null) {
        var navigator = Navigator.of(context);
        List<Movie> result =
            await MovieController.to.searchWithTitle(searchTitle);
        navigator.push(MaterialPageRoute(builder: (context) {
          return SearchResultScreen(searchResult: result);
        }));
        return;
      }
      if (searchTitle.isEmpty && searchDate != null) {
        var navigator = Navigator.of(context);
        List<Movie> result =
            await MovieController.to.searchWithDate(searchDate!);
        navigator.push(MaterialPageRoute(builder: (context) {
          return SearchResultScreen(searchResult: result);
        }));
        return;
      }
      if (searchTitle.isNotEmpty && searchDate != null) {
        var navigator = Navigator.of(context);
        List<Movie> result = await MovieController.to
            .searchWithTitleAndDate(searchTitle, searchDate!);
        navigator.push(MaterialPageRoute(builder: (context) {
          return SearchResultScreen(searchResult: result);
        }));
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
            onPressed: () => searchPressed(context),
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
