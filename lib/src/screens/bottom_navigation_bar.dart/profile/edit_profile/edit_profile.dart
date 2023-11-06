import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_1/src/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/change_password/bloc_change_pwd.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/change_password/event_change_pwd.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/update_user_profile/bloc_uu_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/update_user_profile/event_uu_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/bloc_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/event_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/state_user_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>(
          create: (context) => UserProfileBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateUserProfileBloc(),
        ),
        BlocProvider<ChangePwdBloc>(
          create: (context) => ChangePwdBloc(),
        ),
      ],
      child: const EditUserProfile(),
    );
  }
}

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final formGlobalKey = GlobalKey<FormState>();
//  final TextEditingController name = TextEditingController();
  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _phone = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _cnfpwd = TextEditingController();

  bool passwordVisible = false;
  bool visiblePassword = false;

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileBtnEvent());
    passwordVisible = true;
    visiblePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        title: const Text('Edit Profile'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
        ),
        actions: const <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserProfileLoadedState) {
                final TextEditingController name = TextEditingController(
                    text: state.userProfile.userProfileData.name);
                final TextEditingController email = TextEditingController(
                    text: state.userProfile.userProfileData.email);
                final TextEditingController phone = TextEditingController(
                    text: state.userProfile.userProfileData.mobileNo);

                return Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              image == null
                                  ? const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 68,
                                      backgroundImage: NetworkImage(
                                          'https://www.mymasala.in/wp-content/uploads/2022/05/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg'),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 68,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(125),
                                        child: Image.file(
                                          File(image!.path),
                                          fit: BoxFit.fill,
                                          height: 140,
                                          width: 130,
                                        ),
                                      ),
                                    ),
                              Positioned(
                                right: 5,
                                top: 100,
                                child: InkWell(
                                  onTap: () async {
                                    image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      //update UI
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey[200],
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Basic Information',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Name'),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //  color: bgColor,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: name,
                              decoration: const InputDecoration(
                                hintText: "......",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Phone'),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //  color: bgColor,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: phone,
                              decoration: const InputDecoration(
                                hintText: "......",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Email'),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //  color: bgColor,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: "......",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<UpdateUserProfileBloc>(context)
                                  .add(UpdateUserProfileBtnEvent(
                                      name: name.text,
                                      mobileNo: phone.text,
                                      email: email.text));
                              _showToast('User Profile Updated SuccessFully');
                              // print('NAME:$name');
                              // print('PHONE:$phone');
                              // print('EMAIL:$email');
                            },
                            child: Container(
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  'Update Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Password Changes',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Enter New Password'),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //  color: bgColor,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: _pwd,
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                hintText: "......",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Re-Enter New Password'),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //  color: bgColor,
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              autofocus: false,
                              controller: _cnfpwd,
                              obscureText: visiblePassword,
                              decoration: InputDecoration(
                                hintText: "......",
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      visiblePassword = !visiblePassword;
                                    });
                                  },
                                  icon: Icon(
                                    visiblePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_pwd.text.isEmpty) {
                                _showToast('Enter Password');
                              } else if (_cnfpwd.text.isEmpty) {
                                _showToast("Enter Confirmed Password");
                              } else {
                                BlocProvider.of<ChangePwdBloc>(context).add(
                                    ChangePwdBtnEvent(
                                        password: _pwd.text,
                                        cnfPassword: _cnfpwd.text));
                                _showToast('Password Change Successfully...!');
                                // print('PASSWORD:$_pwd');
                                // print('CNF PASSWORD:$_cnfpwd');
                              }
                            },
                            child: Container(
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: Text(
                                  'Update Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is UserProfileErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

void _showToast(String message) {
  // Show a toast message
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
