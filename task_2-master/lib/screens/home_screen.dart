import 'package:flutter/material.dart';
import 'package:task_1/model/api_model.dart';
import 'package:task_1/repositories/api_repo.dart';
import 'package:task_1/widgets/custom_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getProviderData();
  }

  final TextEditingController controller = TextEditingController();
  bool _isloadingData = true;
  bool _isSearched = false;
  List<Tag> data = [];
  List<Tag> localList = [];
  void _getProviderData() async {
    data = await ApiRepo().getTags();
    if (data.isNotEmpty) {
      setState(() {
        _isloadingData = !_isloadingData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: controller,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.only(left: 15),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        var index = data.indexWhere((element) =>
                            element.displayName == controller.text);
                        var desIndex = data.indexWhere((element) =>
                            element.description == controller.text);
                        setState(() {
                          _isSearched = true;

                          localList.add(
                              (index == null) ? data[desIndex] : data[index]);
                        });
                      },
                    ),
                    fillColor: Colors.blue[100].withOpacity(0.2),
                    hintText: 'Search here',
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _isloadingData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _isSearched ? localList.length : data.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 15,
                          );
                        },
                        itemBuilder: (context, index) {
                          return _isSearched
                              ? Column(
                                  children: [
                                    CustomCard(
                                      data: localList[index],
                                    ),
                                    (index == localList.length - 1)
                                        ? TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isSearched = false;
                                                localList.clear();
                                              });
                                            },
                                            child: Text('Back'),
                                          )
                                        : Container()
                                  ],
                                )
                              : CustomCard(
                                  data: data[index],
                                );
                        },
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
