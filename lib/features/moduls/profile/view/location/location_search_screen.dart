import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSearchScreen extends StatefulWidget {
  final String title;
  final String type;
  final String selectedValue;
  final RxList<String> dataList;

  const LocationSearchScreen({
    super.key,
    required this.title,
    required this.type,
    required this.selectedValue,
    required this.dataList,
  });

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController searchController = TextEditingController();

  RxList<String> filteredList = <String>[].obs;

  @override
  void initState() {
    super.initState();
    filteredList.value = List.from(widget.dataList);
  }

  void filterSearch(String value) {
    if (value.isEmpty) {
      filteredList.value = widget.dataList;
    } else {
      filteredList.value =
          widget.dataList
              .where((e) => e.toLowerCase().contains(value.toLowerCase()))
              .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // 🔍 SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: "Search ${widget.type}",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // 📋 LIST
          Expanded(
            child: Obx(() {
              if (filteredList.isEmpty) {
                return Center(child: Text("No Data Found"));
              }
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final item = filteredList[index];
                  return ListTile(
                    title: Text(item),
                    trailing:
                        item == widget.selectedValue
                            ? Icon(Icons.check, color: Colors.green)
                            : null,
                    onTap: () {
                      Navigator.pop(context, item);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
