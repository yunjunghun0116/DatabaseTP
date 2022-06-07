import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/controllers/user_manage_controller.dart';
import 'package:movie_cnu_web/models/user.dart';

class UserManageScreen extends StatelessWidget {
  const UserManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UserManageController.to.getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> userList = snapshot.data as List<User>;
            return ListView(
              children: userList.map((User user){
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLightGreyColor,
                      )
                    )
                  ),
                  child: ListTile(
                    onTap: (){},
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('유저 ID : ${user.id}'),
                        Text('성별 : ${user.gender}'),
                        Text('유저 이메일 : ${user.email}'),
                        Text('생년월일 : ${user.birthDate.toString().substring(0,10)}'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
