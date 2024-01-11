import 'package:flutter/material.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/learn-topic.dart';
import 'package:individual_project/models/tutor/tutor-info.dart';
import 'package:individual_project/models/tutor/tutor.dart';
import 'package:individual_project/pages/tutors/widgets/filter.dart';
import 'package:individual_project/pages/tutors/widgets/tutor-item.dart';
import 'package:individual_project/global.state/tutor-filter.dart';
import 'package:individual_project/services/tutor.service.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class ListTutorsView extends StatefulWidget {
  const ListTutorsView({Key? key}) : super(key: key);
  @override
  _ListTutorsState createState() => _ListTutorsState();
}

class _ListTutorsState extends State<ListTutorsView> {
  List<Tutor> _tutors = [];
  List<TutorInfo> _tutorInfos = [];
  List<dynamic> _specialties = [];
  bool isLoading = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final MultiSelectController<NationalityFilter> _controller =
      MultiSelectController<NationalityFilter>();

  void getTutorList(String token, int perPage, int page,
      AuthProvider authProvider, TutorFilter tutorFilter) async {
    List<dynamic> specialties = [];
    specialties.add(LearnTopic(id: 0, key: 'all', name: 'ALL'));
    specialties.addAll(authProvider.userLoggedIn.learnTopics!);
    specialties.addAll(authProvider.userLoggedIn.testPreparations!);

    List<TutorInfo> tutorInfos = [];

    if (tutorFilter.isFilterTutor()) {
      tutorFilter.setSearching(true);
      tutorInfos = await TutorService.searchTutor(
        page,
        perPage,
        token,
        tutorFilter.getName(),
        [],
        tutorFilter.selectedNationality.toList() ?? [],
      );
    } else {
      tutorInfos = await TutorService.getTutors(token, perPage, page);
    }

    List<Tutor> tutors = [];
    for (int i = 0; i < tutorInfos.length; i++) {
      final tutor =
          await TutorService.getTutorById(token, tutorInfos[i].userId);
      tutors.add(tutor);
    }

    if (mounted) {
      setState(() {
        _tutors = tutors;
        _specialties = specialties;
        _tutorInfos = tutorInfos;
        isLoading = false;
        tutorFilter.setSearching(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tutorFilter = Provider.of<TutorFilter>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    if (isLoading || tutorFilter.isFilterTutor()) {
      getTutorList(
          authProvider.getAccessToken(), 9, 1, authProvider, tutorFilter);
    }

    return Container(
        padding: EdgeInsets.fromLTRB(30, 33, 30, 49),
        child: Column(
          children: [
            Filter(
                specialties: _specialties,
                nameController: nameController,
                countryController: countryController,
                controller: _controller),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                alignment: Alignment.topLeft,
                child: Text(
                  "Recommended Tutors",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),

            // List of tutors sorted by favorite and rating
            (!isLoading)
                ? Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: this._tutors.length,
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
                : const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ));
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
