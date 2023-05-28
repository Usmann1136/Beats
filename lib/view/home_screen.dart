import 'package:beats/res/constants/app_color.dart';
import 'package:beats/res/constants/text_style.dart';
import 'package:beats/view%20model/player_view_model.dart';
import 'package:beats/view/player_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(PlayerViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgDarkColor,
        appBar: AppBar(
          backgroundColor: AppColor.bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppColor.whiteeColor,
                ))
          ],
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.sort_rounded,
                  color: AppColor.whiteeColor,
                ),
              ),
              Image.asset('images/beats_image.png'),
              Text(
                'Beats',
                style: ourStyle(
                  size: 18,
                  family: "Poppins Courgrette",
                ),
              ),
            ]),
          )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Column(children: [
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                  future: homeController.audioQuery.querySongs(
                    ignoreCase: true,
                    orderType: OrderType.ASC_OR_SMALLER,
                    sortType: null,
                    uriType: UriType.EXTERNAL,
                  ),
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No Songs Available',
                          style: ourStyle(family: 'Poppins Courgette'),
                        ),
                      );
                    } else
                      return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 20),
                          itemBuilder: (context, index) {
                            return Obx(
                              () => ListTile(
                                onTap: () {
                                  Get.to(
                                      () => PlayerScreen(
                                            data: snapshot.data!,
                                          ),
                                      transition: Transition.downToUp);
                                  homeController.playSong(
                                      snapshot.data![index].uri, index);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor: AppColor.bgColor,
                                leading: QueryArtworkWidget(
                                  id: snapshot.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Icon(
                                    Icons.music_note,
                                    color: AppColor.whiteeColor,
                                    size: 32,
                                  ),
                                ),
                                title: Text(
                                  snapshot.data![index].displayNameWOExt,
                                  style: ourStyle(
                                      family: "Poppins Courgrette", size: 12),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].artist.toString(),
                                  style: ourStyle(
                                      family: "Poppins Courgrette", size: 10),
                                ),
                                trailing:
                                    homeController.playIndex.value == index &&
                                            homeController.isPlaying.value
                                        ? Icon(
                                            Icons.play_arrow_rounded,
                                            size: 26,
                                            color: AppColor.whiteeColor,
                                          )
                                        : null,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: snapshot.data!.length);
                  }),
            ),
          ]),
        ));
  }
}
