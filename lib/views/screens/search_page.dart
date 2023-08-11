import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking_app/models/db_model.dart';
import 'package:hotel_booking_app/views/screens/components/Helpers/db_helepers.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<DbModel>?> getAllData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData = Db_Helper.db_helper.fetchAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Category Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    getAllData = Db_Helper.db_helper.FetchsearchData(data: val);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search Category here....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder(
              future: getAllData,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  List<DbModel>? data = snapshot.data;
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text("Data is Not Available.."),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("${data[index].category_name}"),
                          subtitle: Text("${data[index].id}"),
                          leading: CircleAvatar(
                            child: Image.memory(data[index].category_image),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Get.snackbar('Budget Tracker App',
                                  'Data is succesfully delete...');
                              setState(() {
                                Db_Helper.db_helper
                                    .DeleteCategory(id: data[index].id!);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    );
                  }
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
