/*// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
// import 'package:mediapp/consts/list.dart';
// import 'package:mediapp/controlers/home_controller.dart';
// import 'package:mediapp/res/components/custom_textfeild.dart';
// import 'package:mediapp/views/category_details_view/category_details_view.dart';
import 'package:mediapp/views/doctor_profile_view/doctor_profile_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});
  
  get index => null;
  
  // get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
            title: "Searched Results",
            color: AppColors.textColor,
            size: AppSizes.size18),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // var data = snapshot.data?.docs;
            // var index;
            var doc = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: AppColors.bgDarkColor,
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(right: 8),
                    height: 100,
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: AppColors.blueColor,
                          child: Image.asset(
                            AppAssets.imgDoctor,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        5.heightBox,
                        AppStyles.normal(title: doc['docName']),
                        VxRating(
                          selectionColor: AppColors.yelloColor,
                          onRatingUpdate: (value) {},
                          maxRating: 5,
                          count: 5,
                          value:
                              double.parse(doc['docRating'].toString()),
                          stepInt: true,
                        )
                      ],
                    ),
                  ).onTap(() {
                    Get.to(() => DoctorProfileView(doc: doc[index]));
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}*/

import 'dart:math';

import 'package:flutter/material.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mediapp/consts/consts.dart';
import 'package:mediapp/views/doctor_profile_view/doctor_profile_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({Key? key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Searched Results",
          color: AppColors.textColor,
          size: AppSizes.size18,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 170,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data!.docs[index];

                  // log(doc.data().toString());
                  
                  return !doc['docName'].toString().toLowerCase().contains(searchQuery.toLowerCase())
                      ? const SizedBox.shrink()
                      : GestureDetector(
                        onTap: (){
                          Get.to(() => DoctorProfileView(doc: doc));
                        },
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColors.bgDarkColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            height: 100,
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  color: AppColors.blueColor,
                                  child: Image.asset(
                                    AppAssets.imgDoctor,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                AppStyles.normal(title: doc['docName']),
                                VxRating(
                                  selectionColor: AppColors.yelloColor,
                                  onRatingUpdate: (value) {},
                                  maxRating: 5,
                                  count: 5,
                                  value:
                                      double.parse(doc['docRating'].toString()),
                                  stepInt: true,
                                ),
                              ],
                            ),
                          )
                      );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
