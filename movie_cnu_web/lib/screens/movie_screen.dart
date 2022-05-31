import 'package:flutter/material.dart';
import 'package:movie_cnu_web/constants.dart';
import 'package:movie_cnu_web/services/firebase_service.dart';
import 'package:movie_cnu_web/widgets/upload_movie_dialog.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseService().getRunningMovie(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const UploadMovieDialog();
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: kBlackColor),
                        ),
                        child: const Text('영화추가'),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
