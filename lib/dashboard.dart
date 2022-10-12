import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pts/db_helper.dart';
import 'package:flutter_pts/detail.dart';
import 'package:flutter_pts/favorit_model.dart';
import 'package:flutter_pts/football_model.dart';
import 'package:flutter_pts/like_page.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Football_model? model;
  bool isLoad = true;

  void getFootballList() async {
    setState(() {
      isLoad = false;
    });

    final response = await http.get(Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=English%20Premier%20League"));
    model = Football_model.fromJson(json.decode(response.body));

    setState(() {
      isLoad = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFootballList();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? Scaffold(
            backgroundColor: Color(0xFFF9F9F9),
            appBar: AppBar(
                backgroundColor: Colors.indigo,
                title: Text("List Football"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ListFav()));
                    },
                    icon: Icon(Icons.thumb_up),
                  )
                ]),
            body: ListView.builder(
                itemCount: model!.teams!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Detail(detailModel: model!.teams![index])));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                  child: Image.network(model!
                                      .teams![index].strTeamBadge
                                      .toString())),
                            ),
                            Container(
                              child: Text(
                                model!.teams![index].strTeam.toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
  }

// Future<bool> onLikeButtonTapped(bool checkExist) async {
//   return !checkExist ? addData(namaTeam, teamBadge) : deleteData(namaTeam);
// }
}
