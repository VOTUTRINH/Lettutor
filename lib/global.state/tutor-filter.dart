import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

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
  late String specialties = "";
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
    if (nationalityFilters.isEmpty) {
      selectedNationality = [];
      isSearching = true;

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
    isSearching = true;

    notifyListeners();
  }

  removeNationalityFilter(String key) {
    selectedNationality.removeWhere((element) => element?.key == key);
    List<NationalityFilter?> nationalityFilters = [];
    nationalityFilters.addAll(selectedNationality);
    addNationalityFilter(nationalityFilters);
  }

  getspecialties() {
    return specialties;
  }

  setName(String name) {
    isSearching = true;
    this.name = name.trim();
    notifyListeners();
  }

  getName() {
    return name;
  }

  setCountry(String country) {
    this.country = country.trim();
    notifyListeners();
  }

  getCountry() {
    return country;
  }

  isFilterTutor() {
    return isSearching == true;
  }
}
