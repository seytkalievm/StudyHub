import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/presentation/widgets/folder_view.dart';

import '../../../util/color_codes.dart';
import '../../../widgets/loading_indicator.dart';
import 'for_you_controller.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ForYouController>(() => ForYouController());

    var screenSize = MediaQuery.of(context).size;

    return GetBuilder<ForYouController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: controller.folders.isEmpty
              ? Center(
                  child: controller.isLoading
                      ? const LoadingIndicator()
                      : const Text(
                          "No folders available.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: selectedMenuColor,
                          ),
                        ),
                )
              : kIsWeb
                  ? _webForYouPage(controller, screenSize)
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        const SizedBox(
                          height: 17.5,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.folders.length,
                          itemBuilder: (context, index) {
                            return FolderView(
                              folder: controller.folders[index],
                            );
                          },
                        ),
                      ],
                    ),
        ),
      );
    });
  }

  _webForYouPage(ForYouController controller, Size screenSize) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(108, 20, 102, 5),
        child: DynamicHeightGridView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          crossAxisCount: screenSize.width > 1500
              ? 4
              : screenSize.width > 1300
                  ? 3
                  : screenSize.width > 1000
                      ? 2
                      : 1,
          itemCount: controller.folders.length,
          builder: (context, index) {
            return FolderView(folder: controller.folders[index]);
          },
        ),
      ),
    );
  }
}
