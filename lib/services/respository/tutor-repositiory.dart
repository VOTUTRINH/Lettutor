import 'package:flutter/cupertino.dart';
import 'package:individual_project/models/account.dart';
import 'package:individual_project/models/booking.dart';
import 'package:individual_project/models/tutor.dart';

class TutorRepository extends ChangeNotifier {
  List<Tutor> tutorList = [
    Tutor(
      userId: "1",
      avatar:
          "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
      name: "Nguyen Van A",
      description:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
      specialties: "English for kids,English for Business",
      education: "BA",
      experience: "I have more than 10 years of teaching english experience",
      languages: "English",
      interests:
          "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
      country: "VN",
      video:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      rating: 2,
      isFavorite: true,
    ),
    Tutor(
      userId: "2",
      avatar:
          "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
      name: "Nguyen Van B",
      specialties:
          "English for kids,English for Business,Conversational,STARTERS",
      education: "BA",
      experience: "I have more than 10 years of teaching english experience",
      languages: "English",
      interests:
          "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
      country: "VN",
      video:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      rating: 5,
      isFavorite: false,
    ),
    Tutor(
        userId: "3",
        avatar:
            "https://cdn.tuoitre.vn/thumb_w/730/2019/5/8/avatar-publicitystill-h2019-1557284559744252594756.jpg",
        name: "Nguyen Van C",
        specialties:
            "English for kids,English for Business,Conversational,STARTERS",
        education: "BA",
        experience: "I have more than 10 years of teaching english experience",
        languages: "English",
        interests:
            "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
        country: "VN",
        video:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        rating: 4,
        isFavorite: true),
  ];

  List<Tutor> getTutorList() {
    return tutorList;
  }

  void add(Tutor tutor) {
    tutorList.add(tutor);
    notifyListeners();
  }

  void update(Tutor tutor) {
    tutorList[tutorList
        .indexWhere((element) => element.userId == tutor.userId)] = tutor;
    notifyListeners();
  }
}
