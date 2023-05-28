import 'package:beats/res/constants/app_color.dart';
import 'package:beats/view%20model/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../res/constants/text_style.dart';

class PlayerScreen extends StatefulWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key, required this.data});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final playcontroller = Get.put(PlayerViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgDarkColor,
        appBar: AppBar(
            flexibleSpace: SafeArea(
                child: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(children: [
            Center(
              child: Row(
                children: [
                  Image.asset('images/beats_image.png'),
                  Text(
                    'Beats',
                    style: ourStyle(
                      size: 18,
                      family: "Poppins Courgrette",
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ))),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Obx(
            () => Column(
              children: [
                Obx(
                  () => Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: QueryArtworkWidget(
                        id: widget.data[playcontroller.playIndex.value].id,
                        type: ArtworkType.AUDIO,
                        artworkHeight: double.infinity,
                        artworkWidth: double.infinity,
                        nullArtworkWidget: Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColor.whiteeColor)),
                            child: Icon(
                              Icons.music_note,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.data[playcontroller.playIndex.value]
                              .displayNameWOExt,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: ourStyle(
                              color: AppColor.bgColor,
                              size: 20,
                              family: 'Poppins Courgrette'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            widget.data[playcontroller.playIndex.value].artist
                                .toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: ourStyle(
                                color: AppColor.bgColor,
                                size: 16,
                                family: 'Poppins Courgrette')),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Obx(
                            () => Row(
                              children: [
                                Text(playcontroller.position.value,
                                    style: ourStyle(
                                      family: 'Poppins Courgrette',
                                      color: AppColor.bgDarkColor,
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                    child: Slider(
                                        activeColor: AppColor.sliderColor,
                                        thumbColor: AppColor.sliderColor,
                                        inactiveColor: AppColor.bgColor,
                                        min: Duration(seconds: 0)
                                            .inSeconds
                                            .toDouble(),
                                        label: playcontroller
                                            .audioPlayer.position.inMinutes
                                            .toString(),
                                        max: playcontroller.max.value,
                                        value: playcontroller.value.value,
                                        onChanged: (newValue) {
                                          playcontroller
                                              .chooseDurationToSeconds(
                                                  newValue.toInt());
                                          newValue = newValue;
                                        })),
                                Text(
                                  playcontroller.duration.value,
                                  style: ourStyle(
                                    family: 'Poppins Courgrette',
                                    color: AppColor.bgDarkColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  playcontroller.playSong(
                                      widget
                                          .data[playcontroller.playIndex.value -
                                              1]
                                          .uri,
                                      playcontroller.playIndex.value - 1);
                                },
                                icon: Icon(
                                  Icons.skip_previous_rounded,
                                  size: 40,
                                  color: AppColor.bgDarkColor,
                                )),
                            Obx(
                              () => CircleAvatar(
                                radius: 35,
                                backgroundColor: AppColor.bgDarkColor,
                                child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                      onPressed: () {
                                        if (playcontroller.isPlaying.value) {
                                          playcontroller.audioPlayer.pause();
                                          playcontroller.isPlaying(false);
                                        } else {
                                          playcontroller.audioPlayer.play();
                                          playcontroller.isPlaying(true);
                                        }
                                      },
                                      icon: playcontroller.isPlaying.value
                                          ? Icon(
                                              Icons.pause,
                                              color: AppColor.whiteeColor,
                                            )
                                          : Icon(
                                              Icons.play_arrow_rounded,
                                              color: AppColor.whiteeColor,
                                            ),
                                    )),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  playcontroller.playSong(
                                      widget
                                          .data[playcontroller.playIndex.value +
                                              1]
                                          .uri,
                                      playcontroller.playIndex.value + 1);
                                },
                                icon: Icon(
                                  Icons.skip_next_rounded,
                                  size: 40,
                                  color: AppColor.bgDarkColor,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
