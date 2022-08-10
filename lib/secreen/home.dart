import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/main.dart';
import 'package:notes/models/dark-mode.dart';
import 'package:notes/secreen/note_list_page.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // VoidCallback onSubmitPressed;
  // final nicknameController = TextEditingController();
  // String nicknameKey = "nickname";

  // onNicknameTyped() {
  //   if (nicknameController.text.isNotEmpty) {
  //     setState(() => onSubmitPressed = onSubmitPressedTask);
  //   } else {
  //     setState(() => onSubmitPressed = null);
  //   }
  // }

  // onSubmitPressedTask() {
  //   nickname = nicknameController.text;
  //   preferences.setString(nicknameKey, nicknameController.text);
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (_) => const NoteListPage())
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //  nicknameController.addListener(onNicknameTyped);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Image.asset('assets/images/home.png'),
            const SizedBox(
              height: 150,
            ),
            // Expanded(
            //   flex: 3,
            //   child: UnconstrainedBox(
            //     constrainedAxis: Axis.horizontal,
            //     child: ClipRRect(
            //       borderRadius: const BorderRadius.all(Radius.circular(8)),
            //       child: BackdropFilter(
            //         //filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //         child: Container(
            //           padding: const EdgeInsets.all(16),
            //           //  decoration: nicknameBackgroundDecoration,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 "Type your nickname",
            //               ),
            //               const SizedBox(height: 16),
            //               TextField(
            //                   controller: nicknameController,
            //                   //  decoration: nicknameDecoration,
            //                   textAlign: TextAlign.center,
            //                   maxLength: 12,
            //                   maxLines: 1),
            //               const SizedBox(height: 8),
            //               ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                   primary: Colors.white,
            //                 ),
            //                 onPressed: onSubmitPressed,
            //                 child: const Text(
            //                   "Submit",
            //                   style: TextStyle(
            //                       color: Color.fromARGB(255, 106, 0, 255)),
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            FlatButton(
              textColor: Colors.white,
              height: 60,
              minWidth: 300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              splashColor: Colors.red,
              color: Color.fromARGB(255, 106, 0, 255),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteListPage()),
                );
              },
              child: Text(
                'Get Started'.tr(),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
