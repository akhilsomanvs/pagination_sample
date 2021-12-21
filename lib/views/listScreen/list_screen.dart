import 'package:flutter/material.dart';
import 'package:flutter_arch_utils/flutter_arch_utils.dart';
import 'package:get/get.dart';
import 'package:pagination_sample/controller/list_screen_controller.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  double _usableHeight = 0;

  late ScrollController scrollController;
  ListScreenController controller = Get.find();

  @override
  void initState() {
    scrollController = new ScrollController()..addListener(_scrollListener);
    controller.invokeAPi();
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (scrollController.position.extentAfter <= 0) {
        controller.invokeAPi();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 12.sp());
    return Scaffold(
      body: ResponsiveSafeArea(
        builder: (context, size) {
          if (_usableHeight < size.height) {
            _usableHeight = size.height;
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: _usableHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.vdp(), horizontal: 16.hdp()),
                child: Obx(
                  () => Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) {
                            var item = controller.data[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.vdp()),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage("${item.image}"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  HSpace(8),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.firstName, style: _textStyle.copyWith(fontWeight: FontWeight.bold)),
                                      VSpace(4),
                                      Text(item.firstName, style: _textStyle.copyWith(color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.isLoading.value,
                          child: LinearProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
