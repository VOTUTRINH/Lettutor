import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:individual_project/constants/list_country.dart';
import 'package:individual_project/constants/list_level.dart';
import 'package:individual_project/global.state/auth-provider.dart';
import 'package:individual_project/models/tokens.dart';
import 'package:individual_project/models/user/learning-topic.dart';
import 'package:individual_project/models/user/test-preparation.dart';
import 'package:individual_project/pages/profile/widgets/birthday.dart';
import 'package:individual_project/pages/profile/widgets/disabled_input.dart';
import 'package:individual_project/pages/profile/widgets/dropdown_edit.dart';
import 'package:individual_project/pages/profile/widgets/want_to_learn.dart';
import 'package:individual_project/services/user.service.dart';
import 'package:individual_project/widgets/appBar.dart';
import 'package:individual_project/widgets/avatar.dart';
import 'package:individual_project/widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  bool isLoading = true;
  late DateTime? _birthday;
  String? _phone;
  String? _country;
  String? _level;
  String? _email;
  List<LearnTopic> _topics = [];
  List<TestPreparation> _tests = [];
  final ImagePicker _picker = ImagePicker();

  setForm(
      {DateTime? birthday,
      String phone = "",
      String country = "",
      String level = "",
      String email = ""}) {
    setState(() {
      if (email.isNotEmpty) {
        _email = email;
      }
      _birthday = birthday ?? DateTime.now();
      if (phone.isNotEmpty) {
        _phone = phone;
      }
      if (country.isNotEmpty) {
        _country = country;
      }
      if (level.isNotEmpty) {
        _level = level;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    if (isLoading) {
      setState(() {
        _nameController.text = authProvider.userLoggedIn.name;
        _email = authProvider.userLoggedIn.email;
        _birthday = authProvider.userLoggedIn.birthday != null
            ? DateFormat("yyyy-MM-dd")
                .parse(authProvider.userLoggedIn.birthday as String)
            : DateFormat("yyyy-MM-dd").parse("1999-01-22");
        _phone = authProvider.userLoggedIn.phone;
        _country = authProvider.userLoggedIn.country != null
            ? (authProvider.userLoggedIn.country as String)
            : "VN";
        _level = authProvider.userLoggedIn.level ?? "BEGINNER";
        _topics = authProvider.userLoggedIn.learnTopics ?? [];
        _tests = authProvider.userLoggedIn.testPreparations ?? [];
        isLoading = false;
      });
    }

    void _imgFromGallery() async {
      var pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      if (pickedFile != null) {
        final bool res = await UserService.uploadAvatar(
            pickedFile.path, authProvider.tokens!.access.token);
        if (res) {
          final newInfo =
              await UserService.getUserInfo(authProvider.getAccessToken());

          if (newInfo != null) {
            authProvider.setUser(newInfo);
          } else {}

          setState(() {
            isLoading = true;
          });

          showSnackBar('Upload avatar success');
        } else {
          showSnackBar('Upload avatar failed');
        }
      }
    }

    return Scaffold(
        appBar: AppBar(title: AppBarCustom()),
        endDrawer: DrawerCustom(),
        body: SingleChildScrollView(
            child: isLoading
                ? const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.fromLTRB(10, 35, 10, 35),
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 100,
                            width: 100,
                            child: CircularImage(
                                imageUrl: authProvider.userLoggedIn.avatar),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: GestureDetector(
                              onTap: _imgFromGallery,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 15,
                                child: SvgPicture.asset(
                                  "images/edit.svg",
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(authProvider.userLoggedIn.name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500)),
                      Text(authProvider.userLoggedIn.email,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500)),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 7, left: 5),
                              child: Text("Name",
                                  style: const TextStyle(fontSize: 17)),
                            ),
                            TextField(
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey[900]),
                              controller: _nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintText: 'Name',
                              ),
                            )
                          ],
                        ),
                      ),
                      DisabledInput(
                          title: "Email",
                          hintText: "Email address",
                          changeValue: setForm,
                          phone: _email ?? "",
                          isActivated: false),
                      DropdownEdit(
                        title: 'Country',
                        selectedItem: getKeyOfCountry(_country ?? "VN"),
                        items: countryList,
                        onChange: setForm,
                        fieldName: "Country",
                      ),
                      DisabledInput(
                          title: "Phone",
                          hintText: "Phone number",
                          changeValue: setForm,
                          phone: _phone ?? "",
                          isActivated:
                              authProvider.userLoggedIn.isPhoneActivated ??
                                  false),
                      BirthdayEdition(
                          setBirthday: setForm, birthday: _birthday),
                      DropdownEdit(
                        title: 'Level',
                        selectedItem:
                            _level != null ? _level as String : "BEGINNER",
                        items: listLevel,
                        onChange: setForm,
                        fieldName: "Level",
                      ),
                      WantToLearn(
                          userTopics: _topics,
                          editTopics: editTopics,
                          userTestPreparations: _tests,
                          editTestPreparations: editTests),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_phone != null && _phone?.isEmpty as bool) {
                            } else if (_nameController.text.isEmpty) {
                            } else if (_birthday != null &&
                                _birthday!.millisecondsSinceEpoch >
                                    DateTime.now().millisecondsSinceEpoch) {
                            } else {
                              String _bdArg =
                                  "${_birthday!.year.toString()}-${_birthday!.month.toString().padLeft(2, "0")}-${_birthday!.day..toString().padLeft(2, "0")}";

                              final res = await UserService.updateUserInfo(
                                authProvider.tokens!.access.token,
                                _nameController.text,
                                _country as String,
                                _bdArg,
                                _level as String,
                                _topics.map((e) => e.id.toString()).toList(),
                                _tests.map((e) => e.id.toString()).toList(),
                              );
                              if (res != null) {
                                authProvider.logIn(
                                    res, authProvider.tokens as Tokens);
                                showSnackBar('Update profile success');
                                setState(() {
                                  isLoading = true;
                                });
                              } else {
                                showSnackBar('Update profile failed');
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 13, bottom: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Save',
                                    style: const TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff007CFF),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                    ]))));
  }

  getKeyOfCountry(String value) {
    for (var item in countryList.entries) {
      if (item.value == value || item.key == value) {
        return item.key;
      }
    }
    return "VN";
  }

  editTopics(List<LearnTopic> topics) {
    setState(() {
      _topics = topics;
    });
  }

  editTests(List<TestPreparation> tests) {
    setState(() {
      _tests = tests;
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
