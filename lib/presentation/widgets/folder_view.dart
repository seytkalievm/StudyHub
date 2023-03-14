import 'package:flutter/material.dart';

import '../../model/models/folder.dart';
import '../util/color_codes.dart';

class FolderView extends StatelessWidget {
  final Folder folder;
  const FolderView({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: const BoxDecoration(
        color: darkCard,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: const Icon(
              Icons.folder_outlined,
              color: unselectedMenuColor,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: Text(
              folder.name,
              style: const TextStyle(
                color: selectedMenuColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
