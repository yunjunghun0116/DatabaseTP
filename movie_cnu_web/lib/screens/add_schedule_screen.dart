import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/controllers/movie_controller.dart';
import 'package:movie_cnu_web/models/movie.dart';

class AddScheduleScreen extends StatefulWidget {
  final Movie movie;
  const AddScheduleScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  int theaterIndex = 0;
  DateTime movieRunningTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: Text('${widget.movie.title} 상영 스케쥴'),
        actions: [
          TextButton(
            onPressed: () async {
              await MovieController.to.addSchedule(widget.movie.id,
                  kTheaterList[theaterIndex]['name'], movieRunningTime);
              Get.back(result: true);
            },
            child: const Text('등록하기'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '완료',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: kBlueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                magnification: 1.0,
                                selectionOverlay: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  )),
                                ),
                                itemExtent: 30,
                                onSelectedItemChanged: (value) {
                                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                                    setState(() {
                                      theaterIndex = value;
                                    });
                                  });
                                },
                                children: kTheaterList.map((e) {
                                  return Text(e['name']);
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: kGreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '상영관 이름 : ${kTheaterList[theaterIndex]['name']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2022, 1, 1),
                  maxTime: DateTime(2023, 12, 31),
                  onConfirm: (DateTime date) {
                    setState(() {
                      movieRunningTime = date;
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: LocaleType.ko,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: kGreyColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '상영 일자 및 시간 : ${movieRunningTime.toString().substring(0, 16)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
