import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;
  final String? bottom;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
    required this.bottom,
  });
}

class onBoradingScreen extends StatefulWidget {
  onBoradingScreen({super.key});
  var boradControl = PageController();
  bool isLast = false;
  List<BoardingModel> boardingList = [
    BoardingModel(
      image:
          'https://www.androidauthority.com/wp-content/uploads/2021/11/send-whatsapp-message-without-saving-contact-siri-shortcut-running.jpg',
      title: '\nWelecome  ChatApp',
      body: 'the world is full of amazing  things to discover',
      bottom: 'Lets Go',
    ),
    BoardingModel(
        image:
            'https://media.istockphoto.com/id/1223342919/photo/latin-man-using-smartphone-at-home.jpg?s=170667a&w=0&k=20&c=ET_9WHo6ERQ1m13Xg59sgzVQD3wqT2AWDCMu4cCx5kg=',
        title: '\nWe are\n the best',
        body: 'ChatApp is the \#1 free App for rest in chat',
        bottom: 'Continue'),
    BoardingModel(
        image:
            'https://formnutrition.com/wp-content/uploads/2019/10/phone-productivity-2.jpg',
        title: '\nEasy Chat Company',
        body: 'chat to friend and my family',
        bottom: 'Lets Start'),
  ];
  @override
  State<onBoradingScreen> createState() => _onBoradingScreenState();
}

class _onBoradingScreenState extends State<onBoradingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorTwo,
      body: PageView.builder(
        onPageChanged: (int index) {
          if (index == widget.boardingList.length - 1) {
            setState(() {
              widget.isLast = true;
            });
            print('last');
          } else {
            print('no last');
            setState(() {
              widget.isLast = false;
            });
          }
        },
        controller: widget.boradControl,
        itemBuilder: (context, index) =>
            BuildBoradingScreen(widget.boardingList[index]),
        itemCount: widget.boardingList.length,
      ),
    );
  }

  Widget BuildBoradingScreen(BoardingModel model) {
    double sized = MediaQuery.of(context).size.height;
    print(sized);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('${model.image}'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: textSkip(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LandingPage()));
              }),
            ),
            // Spacer(),
            Container(
              //10, 90, 50, 30 left, top, right, bottom
              padding: EdgeInsets.fromLTRB(
                  10,
                  sized > 550
                      ? 320
                      :131 
                         ,
                  50,
                  30),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.title}',
                    //style: SharedFonts.primaryBlackFont,
                    softWrap: true,

                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${model.body}',
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sized > 550
                      ? 27
                      :20 ,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SmoothPageIndicator(
                        controller: widget.boradControl,
                        count: widget.boardingList.length,
                        effect: ExpandingDotsEffect(
                            activeDotColor: kPrimaryColorTwo,
                            dotColor: Colors.white,
                            dotHeight: 10,
                            expansionFactor: 4,
                            dotWidth: 10,
                            spacing: 5),
                      ),
                      // Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize: Size(100, 50),
                        ),
                        onPressed: () {
                          if (widget.isLast) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LandingPage()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => NavigationScreen()));
                          } else {
                            widget.boradControl.nextPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        },
                        child: Text(
                          '${model.bottom}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextButton textSkip(
  dynamic tap,
) {
  return TextButton(
      onPressed: tap,
      child: Text(
        'skip',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ));
}

IconButton rectangle(dynamic tap, Color color) {
  return IconButton(
      onPressed: tap,
      icon: Icon(
        Icons.rectangle_rounded,
        size: 26,
        color: color,
      ));
}
