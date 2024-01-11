import 'dart:math';

import 'package:flutter/material.dart';

class NationalityKey {
  static const String isForeign = 'isForeign';
  static const String isVietnamese = 'isVietnamese';
  static const String isNative = 'isNative';
}

class NationalityFilter {
  late String key;
  late bool isSelected;

  NationalityFilter({required this.key, required this.isSelected});
}

class TutorFilter extends ChangeNotifier {
  late String specialties = "all";
  late String name = "";
  late String country = "";
  late bool isSearching = false;
  List<NationalityFilter?> selectedNationality = [];
  var nonSelectedNationality = [
    NationalityFilter(key: NationalityKey.isForeign, isSelected: false),
    NationalityFilter(key: NationalityKey.isVietnamese, isSelected: false),
    NationalityFilter(key: NationalityKey.isNative, isSelected: false)
  ];

  setSearching(bool isSearching) {
    this.isSearching = isSearching;
    notifyListeners();
  }

  setspecialties(String specialties) {
    isSearching = true;
    this.specialties = specialties;
    notifyListeners();
  }

  bool isIncludedNationality(
      List<NationalityFilter?> nationalityFilters, String? key) {
    if (nationalityFilters.isEmpty) {
      return false;
    }

    return nationalityFilters.any((element) => element?.key == key);
  }

  addNationalityFilter(List<NationalityFilter?> nationalityFilters) {
    isSearching = true;
    if (nationalityFilters.isEmpty) {
      selectedNationality = [];
      return;
    }
    selectedNationality.clear();

    if (isIncludedNationality(nationalityFilters, NationalityKey.isForeign)) {
      selectedNationality.addAll(nonSelectedNationality);
      selectedNationality.removeWhere((element) =>
          isIncludedNationality(nationalityFilters, element?.key) == true);
    } else {
      selectedNationality.addAll(nationalityFilters);
      selectedNationality.map((e) => e?.isSelected = true).toList();
      selectedNationality
          .sort((a, b) => a?.key == NationalityKey.isVietnamese ? -1 : 1);
    }
    notifyListeners();
  }

  removeNationalityFilter(String key) {
    selectedNationality.removeWhere((element) => element?.key == key);
    List<NationalityFilter?> nationalityFilters = [];
    nationalityFilters.addAll(selectedNationality);
    addNationalityFilter(nationalityFilters);
  }

  getspecialties() {
    return this.specialties;
  }

  setName(String name) {
    isSearching = true;
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
    return (name.trim() != "" ||
            country.trim() != "" ||
            selectedNationality.isNotEmpty) &&
        isSearching == true;
  }
}
