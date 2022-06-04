import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class SelectGradeBottomSheet extends StatelessWidget {
  const SelectGradeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _grade = kGradeList[0];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('관람등급',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              TextButton(
                onPressed: () {
                  Navigator.pop(context,_grade);
                },
                child: const Text('설정완료',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ],
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
              _grade = kGradeList[value];
            },
            children: kGradeList.map((e) {
              return Text(e);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
