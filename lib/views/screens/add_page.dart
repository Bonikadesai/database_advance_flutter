import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hotel_booking_app/models/db_model.dart';
import 'package:hotel_booking_app/views/screens/components/Helpers/db_helepers.dart';

import '../../utils/Globals/globals.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  TextEditingController categoryNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String categoryName = "";
  ByteData? imgbytes;
  int? selected;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category Page"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // if (formKey.currentState!.validate()) {
          //   formKey.currentState!.save();
          Uint8List categoyimg =
              Uint8List.fromList(imgbytes!.buffer.asUint8List());
          DbModel dbModel = DbModel(
              category_name: categoryNameController.text,
              category_image: categoyimg);
          int? response =
              await Db_Helper.db_helper.addCategory(dbmodel: dbModel);
          if (response! >= 1) {
            Get.snackbar('Budget Tracker App', 'Data is Successfull add ');
          } else {
            Get.snackbar('Budget Tracker App', 'Data is Successfull not add');
          }
          // }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Enter Category Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
              ),
              itemCount: Globals.allCategoryImage.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  imgbytes = await rootBundle.load(
                    Globals.allCategoryImage[index],
                  );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        Globals.allCategoryImage[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
