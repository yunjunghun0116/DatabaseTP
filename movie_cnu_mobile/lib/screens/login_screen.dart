import 'package:flutter/material.dart';
import 'package:movie_cnu_mobile/constants.dart';
import 'package:movie_cnu_mobile/screens/register_screen.dart';

import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CNU Movie App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kBlueColor,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Email',
                onSaved: (value) {},
                validator: (value) {
                  if (value == null || value.length < 2) return '이메일을 입력해주세요!';
                  if (!kEmailRegExp.hasMatch(value)) return '이메일 형식을 확인해주세요!';
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
              GestureDetector(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '로그인하기',
                        style: TextStyle(
                          color: kBlueColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const RegisterScreen();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '회원가입하기',
                        style: TextStyle(
                          color: kGreyColor,
                        ),
                      ),
                    ],
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
