import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import '../widget/chat_bubbel.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'chatPage';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email =ModalRoute.of(context)!.settings.arguments;//as String
    return StreamBuilder<QuerySnapshot>(
        // future: messages.get(), //messages.doc('84bpWOow9HFKkiOiSDPD').get(),
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.data!['message']);
          // print(snapshot.data!.docs[0]['message']);
          List<Message> messagesList = [];
          try {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
          } catch (e) {
            print(e);
          }
          if (snapshot.hasData) {
            //  print(snapshot.data!.docs[0]['message']);
            return Scaffold(
              
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor:  Color(0xff006D84),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 50,
                      ),
                      Text('Chat'),
                    ],
                  )),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return  messagesList[index].id==email?  chatbubble(
                          message: messagesList[index],
                        ):chatbubbleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'id':email,
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error Wait......')),
            );
          } else {
            return Scaffold(
              body: Center(child: Text('loading......')),
            );
          }
        });
  }
}
