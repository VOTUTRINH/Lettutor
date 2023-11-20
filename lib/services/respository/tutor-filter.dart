import 'package:flutter/material.dart';
import 'package:individual_project/services/models/tutor.dart';

class TutorFilter extends ChangeNotifier {
  late String specialties = "ALL";
  late String name = "";
  late String country = "";

  setspecialties(String specialties) {
    this.specialties = specialties;
    notifyListeners();
  }

  getspecialties() {
    return this.specialties;
  }

  setName(String name) {
    this.name = name.trim();
    notifyListeners();
  }

  getName() {
    return this.name;
  }

  setCountry(String country) {
    this.country = country.trim();
    notifyListeners();
  }

  getCountry() {
    return this.country;
  }

  isValidTutor(Tutor tutor) {
    return (specialties == "ALL" ||
            tutor.specialties!.contains(this.specialties)) &&
        (name == "" ||
            tutor.name!.toLowerCase().contains(this.name.toLowerCase())) &&
        (country == "" ||
            tutor.country!.toLowerCase().contains(this.country.toLowerCase()));
  }
}
