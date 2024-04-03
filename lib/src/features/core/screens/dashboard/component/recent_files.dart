import 'package:dashboard/src/features/core/models/RecentFile.dart';
import 'package:dashboard/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Students",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: 20,
              ),

              // const Expanded(child: SearchField()),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Student Name"),
                ),
                DataColumn(
                  label: Text("Student ID"),
                ),
                DataColumn(
                  label: Text("Marks"),
                ),
                DataColumn(
                  // Add an additional column for actions
                  label: Text("Actions"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.name!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.id!)),
      DataCell(Text(fileInfo.marks!)),
      DataCell(
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                // Define onPressed callback for the first ElevatedButton
                // For example, you can handle edit functionality here
                print("Edit button pressed for ${fileInfo.name}");
              },
              child: Text("Edit"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // Define onPressed callback for the second ElevatedButton
                // For example, you can handle delete functionality here
                print("Delete button pressed for ${fileInfo.name}");
              },
              child: Text("Remove"),
            ),
          ],
        ),
      ),
    ],
  );
}
