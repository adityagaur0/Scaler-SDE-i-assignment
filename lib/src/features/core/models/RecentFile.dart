class RecentFile {
  final String? icon, name, id, marks;

  RecentFile({this.icon, this.name, this.id, this.marks});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    name: "Aditya",
    id: "001",
    marks: "94",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    name: "Aryushi",
    id: "002",
    marks: "94",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    name: "Vinay",
    id: "003",
    marks: "32",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    name: "Kaatayayni",
    id: "004",
    marks: "3",
  ),
];
