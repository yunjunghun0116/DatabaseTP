import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/controllers/user_controller.dart';
import 'package:movie_cnu_mobile/screens/main_screen.dart';
import 'package:movie_cnu_mobile/widgets/custom_text_form_field.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  String gender = '남자';
  DateTime birthDate = DateTime.parse('1999-01-16');
  String userId = const Uuid().v4();
  String email = '';
  String password = '';
  String name = '';

  void registerUser() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Map<String, dynamic> userInfo = {
        'id': userId,
        'email': email,
        'password': password,
        'name': name,
        'gender': gender,
        'birthDate': birthDate.toString(),
      };
      final navigator = Navigator.of(context);
      bool registerSuccess =
          await UserController.to.registerUser(userId, userInfo);
      if (registerSuccess) {
        navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
          return const MainScreen();
        }), (route) => false);
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
        title: const Text('회원가입'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CustomTextFormField(
                      label: 'Email',
                      onSaved: (value) {
                        email = value;
                      },
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.length < 2) return '이메일을 입력해주세요!';
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      obsecure: true,
                      onSaved: (value) {
                        password = value;
                      },
                      inputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.length < 2) return '패스워드를 입력해주세요!';
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Name',
                      onSaved: (value) {
                        name = value;
                      },
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
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () =>registerUser(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: kDarkGreyColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('등록하기'),
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
