import 'package:flutter/material.dart';
import 'package:zoma_clone_flutter/constant/colors.dart';

class AppSearchBar extends StatefulWidget {
  final String hintText;

  const AppSearchBar(this.hintText, {super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.separatorGrey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.white,
        child: ListTile(
          dense: true,
          leading: const Icon(Icons.search, color: Colors.black),
          title: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

