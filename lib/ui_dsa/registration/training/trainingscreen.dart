import 'dart:io';

import 'package:dhanvarsha/constants/colors.dart';
import 'package:dhanvarsha/ui/BaseView.dart';
import 'package:dhanvarsha/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrainingScreen();
}

class _TrainingScreen extends State<TrainingScreen> {

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        type: false,
        title: "",
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Training",
                  style: CustomTextStyles.BoldTitileFont,
                ),
              ),
              // YoutubePlayer(
              //   controller: _controller,
              //   showVideoProgressIndicator: true,
              //   actionsPadding: EdgeInsets.symmetric(horizontal: 15),
              //
              // ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listofTraining.length,
                itemBuilder: (
                  context,
                  i,
                ) {
                  print("ID ARE");
                  print(listofTraining.elementAt(i).videoId);
                  return GestureDetector(
                    onTap: () {
                      _launchURL(listofTraining.elementAt(i).videoUrl);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 15, vertical: 10),
                                  //   child: YoutubePlayer(
                                  //     controller: _controller,
                                  //     showVideoProgressIndicator: false,
                                  //     width: SizeConfig.screenWidth * 0.25,
                                  //     actionsPadding:
                                  //         EdgeInsets.symmetric(horizontal: 15),
                                  //   ),
                                  // ),

                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        margin: EdgeInsets.all(10),
                                        height: SizeConfig.screenHeight * 0.10,
                                        child: Image.network(
                                          listofTraining.elementAt(i).videoId,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listofTraining.elementAt(i).title,
                                            style: CustomTextStyles
                                                .MediumBoldLightFont,
                                          ),
                                          Text(
                                            listofTraining
                                                .elementAt(i)
                                                .description,
                                            style: CustomTextStyles
                                                .regularsmalleFonts,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        context: context);
  }

  _launchURL(String url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      var staticurl = url;
      if (await canLaunch(staticurl)) {
        await launch(staticurl);
      } else {
        //SuccessfulResponse.showScaffoldMessage("Couldn't launch apk", context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Couldn't launch apk")));
        throw 'Could not launch $staticurl';
      }
    }
  }
}

class Training {
  final String title;
  final String description;
  final String videoId;
  final String videoUrl;
  final YoutubePlayer youtubePlayerController;

  Training(this.title, this.description, this.videoId, this.videoUrl,
      this.youtubePlayerController);
}

List<Training> listofTraining = [
  new Training(
      "Registration Video",
      "",
      "https://img.youtube.com/vi/6fa1Ogi1JrE/0.jpg",
      "https://youtu.be/6fa1Ogi1JrE",
      YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: '6fa1Ogi1JrE',
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        ),
        showVideoProgressIndicator: false,
        width: SizeConfig.screenWidth * 0.50,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      )),
  new Training(
      "Dashboard Video",
      "",
      "https://img.youtube.com/vi/2XpsEGlUWAo/0.jpg",
      "https://youtu.be/2XpsEGlUWAo",
      YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: '6fa1Ogi1JrE',
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        ),
        showVideoProgressIndicator: false,
        width: SizeConfig.screenWidth * 0.25,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      )),
  new Training(
      "Getting Personal Loan",
      "Personal Loan Can be used for variety of reasons",
      'https://img.youtube.com/vi/UGafgH3-PM8/0.jpg',
      "https://youtu.be/UGafgH3-PM8",
      YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: '6fa1Ogi1JrE',
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        ),
        showVideoProgressIndicator: false,
        width: SizeConfig.screenWidth * 0.25,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      )),
  new Training(
      "Getting Business Loan",
      "Applying for business loan",
      'https://img.youtube.com/vi/vYlVwahplcI/0.jpg',
      "https://youtu.be/vYlVwahplcI",
      YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: '6fa1Ogi1JrE',
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        ),
        showVideoProgressIndicator: false,
        width: SizeConfig.screenWidth * 0.25,
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
      )),
];
