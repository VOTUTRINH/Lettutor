import 'dart:async';

import 'package:flutter/material.dart';
import 'package:individual_project/global.state/app-provider.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
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
  List<Tutor> _tutors = [];
  List<TutorInfo> _tutorInfos = [];
  List<dynamic> _specialties = [];
  bool isLoading = true;
  late TextEditingController nameController;
  late TextEditingController countryController;
  late MultiSelectController<NationalityFilter> _controller;

  Timer? _debounce;

  int page = 1;
  int perPage = 10;
  String? token;
  late TutorFilter tutorFilter;

  void loadMore() async {
    setState(() {
      page++;
    });

    try {
      List<TutorInfo> tutorInfos = await getTutorInfos();
      List<Tutor> tutors = [];
      for (int i = 0; i < tutorInfos.length; i++) {
        final tutor =
            await TutorService.getTutorById(token!, tutorInfos[i].userId);
        tutors.add(tutor);
      }
      if (mounted) {
        setState(() {
          _tutors.addAll(tutors);
          _tutorInfos.addAll(tutorInfos);
          widget.onLoadMoreChange!();
        });
      }
    } catch (e) {
      print(e);
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

    List<TutorInfo> tutorInfos = await getTutorInfos();
    List<Tutor> tutors = [];
    for (int i = 0; i < tutorInfos.length; i++) {
      final tutor =
          await TutorService.getTutorById(token!, tutorInfos[i].userId);
      tutors.add(tutor);
    }

    if (mounted) {
      setState(() {
        _tutors = tutors;
        _specialties = specialties;
        _tutorInfos = tutorInfos;
        isLoading = false;
      });

      tutorFilter.setSearching(false);
    }
  }

  getTutorInfos() async {
    List<TutorInfo> tutorInfos = [];

    if (tutorFilter.isFilterTutor()) {
      tutorFilter.setSearching(true);
      tutorInfos = await TutorService.searchTutor(
        page,
        perPage,
        token!,
        tutorFilter.getName(),
        [],
        tutorFilter.selectedNationality.toList() ?? [],
      );
    } else {
      tutorInfos = await TutorService.getTutors(token!, perPage, page);
    }
    return tutorInfos;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    setState(() {
      token = authProvider.getAccessToken();
      tutorFilter = Provider.of<TutorFilter>(context);
    });
    if (isLoading || tutorFilter.isFilterTutor()) {
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
                  child: _tutors.isEmpty
                      ? const FreeContentWidget('No available tutors')
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _tutors.length,
                          itemBuilder: (context, index) {
                            // Sort the tutorList by favorite and rating
                            _tutors.sort((a, b) {
                              if (a.isFavorite != b.isFavorite) {
                                return a.isFavorite! ? -1 : 1;
                              } else {
                                return b.avgRating!.compareTo(a.avgRating ?? 0);
                              }
                            });
                            return TutorItem(
                                tutor: _tutors[index],
                                feedbacks: _tutorInfos[index].feedbacks);
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
