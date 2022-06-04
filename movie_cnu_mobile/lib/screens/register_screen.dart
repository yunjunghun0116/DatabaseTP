import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/widgets/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String gender = '남자';
  DateTime birthDate = DateTime.parse('1999-01-16');
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = const Uuid().v4();
  }

  void registerUser()async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        foregroundColor: kBlackColor,
        elevation: 1,
        title: const Text('회원가입'),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              label: 'Email',
              obsecure: true,
              onSaved: (value) {},
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.length < 2) return '이메일을 입력해주세요!';
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Password',
              obsecure: true,
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.length < 2) return '패스워드를 입력해주세요!';
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Name',
              obsecure: true,
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.length < 2) return '이름을 입력해주세요!';
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          color: kDarkGreyColor,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('남자'),
                          Radio<String>(
                            value: '남자',
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('여자'),
                          Radio<String>(
                            value: '여자',
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BirthDate',
                            style: TextStyle(
                              fontSize: 16,
                              color: kDarkGreyColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1995, 1, 1),
                                maxTime: DateTime(2012, 12, 31),
                                onConfirm: (DateTime date) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    setState(() {
                                      birthDate = date;
                                    });
                                  });
                                },
                                currentTime: birthDate,
                                locale: LocaleType.ko,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                '생년월일 : ${birthDate.toString().substring(0, 10)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kDarkGreyColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kDarkGreyColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('등록하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
