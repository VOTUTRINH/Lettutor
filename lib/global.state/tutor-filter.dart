import 'package:flutter/material.dart';
import 'package:individual_project/models/tutor/tutor.dart';

class TutorFilter extends ChangeNotifier {
  late String specialties = "all";
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

  isFilterTutor() {
    return specialties != "all" || name.trim() != "" || country.trim() != "";
  }
}
