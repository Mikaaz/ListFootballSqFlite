import 'package:flutter/material.dart';
import 'package:flutter_pts/db_helper.dart';
import 'package:flutter_pts/favorit_model.dart';

class ListFav extends StatefulWidget {
  const ListFav({Key? key}) : super(key: key);

  @override
  State<ListFav> createState() => _ListFavState();
}

class _ListFavState extends State<ListFav> {
  List<Like_Model> dataTeamfavlist = [];
  bool isLoading = false;

  Future read() async {
    setState(() {
      isLoading = true;
    });
    dataTeamfavlist = await FootballDatabase.instance.readAll();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    dataTeamfavlist;
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Like Team"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
          itemCount: dataTeamfavlist.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10),
                height: 100,
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
                            child: Image.network(
                                dataTeamfavlist[index].teambadge.toString())),
                      ),
                      Container(
                        child: Text(
                          dataTeamfavlist[index].title.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
