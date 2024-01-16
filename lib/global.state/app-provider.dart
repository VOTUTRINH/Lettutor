import 'package:flutter/material.dart';
import 'package:individual_project/models/user/learning-topic.dart';
import 'package:individual_project/models/user/test-preparation.dart';

class AppProvider extends ChangeNotifier {
  List<LearnTopic> allLearningTopics = [];
  List<TestPreparation> allTestPreparations = [];
  // List<CourseCategory> allCourseCategories = [];
  // Language _language = English();

  void load(
      List<LearnTopic> learningTopics, List<TestPreparation> testPreparations) {
    allLearningTopics = learningTopics;
    allTestPreparations = testPreparations;
    notifyListeners();
  }

  // void loadCourseCategories(List<CourseCategory> courseCategories) {
  //   allCourseCategories = courseCategories;
  //   notifyListeners();
  // }

  // set language(Language lang) {
  //   _language = lang;
  //   notifyListeners();
  // }

  // Language get language => _language;
}
