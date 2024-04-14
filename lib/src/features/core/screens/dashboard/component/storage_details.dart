import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FloatingActionButton(onPressed: () {}),
          FloatingActionButton(onPressed: () {}),
          FloatingActionButton(onPressed: () {}),
          // Text(
          //   "Student Detail",
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // SizedBox(height: defaultPadding),
          // Chart(),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/Documents.svg",
          //   title: "Documents Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/media.svg",
          //   title: "Media Files",
          //   amountOfFiles: "15.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/folder.svg",
          //   title: "Other Files",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 1328,
          // ),
          // StorageInfoCard(
          //   svgSrc: "assets/icons/unknown.svg",
          //   title: "Unknown",
          //   amountOfFiles: "1.3GB",
          //   numOfFiles: 140,
          // ),
        ],
      ),
    );
  }
}
