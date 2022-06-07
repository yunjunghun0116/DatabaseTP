import 'package:flutter/material.dart';
import 'package:movie_cnu_web/screens/main_screen.dart';
import '../constants.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String email='';
  String password = '';

  void loginPressed(BuildContext context)async{
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      if(email == 'admin@naver.com' && password == 'admin1234'){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
          return const MainScreen();
        }), (route) => false);
        return;
      }
      await showDialog(context: context, builder: (context){
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            height: 80,
            padding: const EdgeInsets.all(16),
            child: const Text('이메일과 비밀번호를 \n다시한번 확인해주세요!!',textAlign: TextAlign.center,),
          ),
        );
      });
    }
  }

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
                onSaved: (value) {
                  email = value;
                },
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
                validator: (value) {
                  if (value == null || value.length < 2) return '패스워드를 입력해주세요!';
                  return null;
                },
              ),
              GestureDetector(
                onTap: ()=>loginPressed(context),
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
            ],
          ),
        ),
      ),
    );
  }
}
