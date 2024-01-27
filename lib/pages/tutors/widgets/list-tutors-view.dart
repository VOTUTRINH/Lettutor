import 'dart:async';

import 'package:flutter/material.dart';
import 'package:individual_project/global.state/app-provider.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/models/user/learning-topic.dart';
import 'package:individual_project/pages/tutors/widgets/filter.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/global.state/tutor-filter.dart';
import 'package:individual_project/services/tutor.service.dart';
import 'package:individual_project/services/user.service.dart';
import 'package:individual_project/widgets/free_content.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class ListTutorsView extends StatefulWidget {
  ListTutorsView({Key? key, this.isLoadMore = false, this.onLoadMoreChange})
      : super(key: key);
  bool isLoadMore;
  final Function? onLoadMoreChange;
  @override
  _ListTutorsState createState() => _ListTutorsState();
}

class _ListTutorsState extends State<ListTutorsView> {
  List<TutorInfo> _tutorInfos = [];
  List<dynamic> _specialties = [];
  bool isLoading = true;
  late TextEditingController nameController;
  late TextEditingController countryController;
  late MultiSelectController<NationalityFilter> _controller;

  String? nameFilter = "";
  List<String>? specialtiesFilter = [];
  List<NationalityFilter>? nationalitiesFilter = [];

  Timer? _debounce;

  int page = 1;
  int perPage = 10;
  String? token;

  void loadMore() async {
    setState(() {
      page++;
    });

    try {
      List<TutorInfo> tutorInfos = await TutorService.searchTutor(
        page,
        perPage,
        token!,
        nameFilter ?? "",
        specialtiesFilter ?? [],
        nationalitiesFilter ?? [],
      );
      if (mounted) {
        setState(() {
          _tutorInfos.addAll(tutorInfos);
          widget.onLoadMoreChange!();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  onFilterChange(
      {String? name,
      List<String>? specialties,
      List<NationalityFilter>? nationalities}) async {
    setState(() {
      page = 1;
      _tutorInfos = [];
      nameFilter = name;
      specialtiesFilter = specialties;
      nationalitiesFilter = nationalities;
    });

    List<TutorInfo> tutorInfos = await TutorService.searchTutor(
      page,
      perPage,
      token!,
      nameFilter ?? "",
      specialtiesFilter ?? [],
      nationalitiesFilter ?? [],
    );

    if (mounted) {
      setState(() {
        _tutorInfos = tutorInfos;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    countryController = TextEditingController();
    _controller = MultiSelectController<NationalityFilter>();
  }

  void getTutorList(AuthProvider authProvider, AppProvider appProvider) async {
    List<dynamic> specialties = [];

    final allTopics = await UserService.getAllLearningTopic(token!);
    final allTestPreparation = await UserService.getAllTestPreparation(token!);
    appProvider.load(allTopics, allTestPreparation);

    List<TutorInfo> tutorInfos = await TutorService.searchTutor(
      page,
      perPage,
      token!,
      nameFilter ?? "",
      specialtiesFilter ?? [],
      nationalitiesFilter ?? [],
    );

    if (mounted) {
      setState(() {
        _specialties = specialties;
        _tutorInfos = tutorInfos;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    setState(() {
      token = authProvider.getAccessToken();
      _specialties = [];
      _specialties.add(LearnTopic(id: 1, key: "", name: "All"));
      _specialties.addAll(appProvider.allLearningTopics);
      _specialties.addAll(appProvider.allTestPreparations);
    });
    if (isLoading) {
      getTutorList(authProvider, appProvider);
    }
    if (widget.isLoadMore) {
      loadMore();
    }
    return Container(
      padding: EdgeInsets.fromLTRB(30, 33, 30, 49),
      child: (!isLoading)
          ? Column(
              children: [
                Filter(
                  specialties: _specialties,
                  nameController: nameController,
                  countryController: countryController,
                  nationalityController: _controller,
                  debounce: _debounce,
                  onFilterChange: onFilterChange,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Recommended Tutors",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),

                // List of tutors sorted by favorite and rating
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: _tutorInfos.isEmpty
                      ? const FreeContentWidget('No available tutors')
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _tutorInfos.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // Sort the tutorList by favorite and rating
                            _tutorInfos.sort((a, b) {
                              if (a.isFavoriteTutor != b.isFavoriteTutor) {
                                return a.isFavoriteTutor! ? -1 : 1;
                              } else {
                                return (b.rating ?? 0).compareTo(a.rating ?? 0);
                              }
                            });
                            return TutorItem(tutor: _tutorInfos[index]);
                          }),
                )
              ],
            )
          : const SizedBox(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
