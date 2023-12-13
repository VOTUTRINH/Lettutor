import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:individual_project/models/feedback.dart';

class FeedbackRepository extends ChangeNotifier {
  List<FeedBack> feedbacks = [
    // FeedBack(
    //     id: "1",
    //     userId: "1",
    //     tutorId: "1",
    //     rating: 5,
    //     content: "Good",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "2",
    //     userId: "2",
    //     tutorId: "1",
    //     rating: 4,
    //     content: "Good job",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "3",
    //     userId: "3",
    //     tutorId: "1",
    //     rating: 3,
    //     content: "Good oke",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "4",
    //     userId: "4",
    //     tutorId: "1",
    //     rating: 2,
    //     content: "Good job",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "5",
    //     userId: "5",
    //     tutorId: "2",
    //     rating: 1,
    //     content: "Not oke",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "6",
    //     userId: "6",
    //     tutorId: "2",
    //     rating: 5,
    //     content: "Good job",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
    // FeedBack(
    //     id: "7",
    //     userId: "7",
    //     tutorId: "2",
    //     rating: 4,
    //     content: "Good job",
    //     createdAt: "2 hours ago",
    //     updatedAt: "2 hours ago"),
  ];

  List<FeedBack> getFeedbacks() {
    return feedbacks;
  }

  List<FeedBack> getFeedbacksByTutorId(String tutorId) {
    // return feedbacks.where((element) => element.tutorId == tutorId).toList();
    return [];
  }

  void add(FeedBack feedback) {
    feedbacks.add(feedback);
    notifyListeners();
  }

  void update(FeedBack feedback) {
    feedbacks[feedbacks.indexWhere((element) => element.id == feedback.id)] =
        feedback;
    notifyListeners();
  }
}
