import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/address/address.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/delete_account/bloc_delete_account.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/bloc_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/event_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/bloc/user_profile/state_user_profile.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/logout_popup.dart';
import 'package:task_1/src/screens/favorites/favorites.dart';
import 'package:task_1/src/screens/cart/cart.dart';
import 'package:task_1/src/screens/bottom_navigation_bar.dart/profile/edit_profile/edit_profile.dart';
import 'package:task_1/src/screens/home/bloc/home_count/bloc_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/event_home_count.dart';
import 'package:task_1/src/screens/home/bloc/home_count/state_home_count.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onTap;
  const ProfileScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCountBloc>(
          create: (context) => HomeCountBloc(),
        ),
        BlocProvider<UserProfileBloc>(
          create: (context) => UserProfileBloc(),
        ),
        BlocProvider<DeleteAccountBloc>(
          create: (context) => DeleteAccountBloc(),
        ),
      ],
      child: Profile(
        onTap: widget.onTap,
      ),
    );
  }
}

class Profile extends StatefulWidget {
  final VoidCallback onTap;
  const Profile({required this.onTap, super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCountBloc>(context).add(HomeCountBtnEvent());
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileBtnEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  toolbarHeight: 50,
        elevation: 0,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 15, top: 37),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent],
            ),
          ),
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserProfileLoadedState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          backgroundImage: NetworkImage(
                              state.userProfile.userProfileData.profileImage),
                          // NetworkImage(
                          //     'https://www.mymasala.in/wp-content/uploads/2022/05/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.userProfile.userProfileData.name,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            state.userProfile.userProfileData.email,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LogoutPopup();
                            });
                      },
                      child: Container(
                        height: 25,
                        width: 70,
                        margin: const EdgeInsets.only(
                          right: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white60,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Log Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orangeAccent, Colors.redAccent],
                ),
              ),
              child: Column(
                children: [
                  BlocBuilder<HomeCountBloc, HomeCountState>(
                    builder: (context, state) {
                      if (state is HomeCountLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is HomeCountLoadedState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 276,
                                height: 65,
                                margin: const EdgeInsets.all(5),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.homeCountData.homeCountModelData
                                            .cartCount
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        'in your cart',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Favorites()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 265,
                                height: 65,
                                margin: const EdgeInsets.all(5),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.homeCountData.homeCountModelData
                                            .favoriteCount
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        'in your wishlist',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.onTap();
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 276,
                                height: 65,
                                margin: const EdgeInsets.all(5),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        state.homeCountData.homeCountModelData
                                            .orderCount
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        'your ordered',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is HomeCountErrorState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const EditProfile(),
                                  ),
                                );
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.person_add_alt_1_outlined),
                                  Text('Edit Profile'),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AddressScreen(),
                                  ),
                                );
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  Text('Address'),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.onTap();
                                });
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.edit_note_outlined),
                                  Text('My Orders'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Favorites(),
                                  ),
                                );
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.favorite_border_outlined),
                                  Text('My Wishlist'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 370,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: Colors.black54,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.quiz_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text('FAQs'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.question_mark),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Terms & Conditions'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.privacy_tip_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Privacy Policy'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.contact_page_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Contact Us'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(Icons.question_mark),
                              SizedBox(
                                width: 20,
                              ),
                              Text('About Us'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Do you want to delete your account from our system?',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  content: const Text(
                                    'Once your account is deleted from our system,you will lose your balance and other information from our system.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            // BlocProvider.of<DeleteAccountBloc>(
                                            //         context)
                                            //     .add(DeleteAccountBtnEvent());
                                          },
                                          child: const Text(
                                            'Yes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete_outline),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Delete My Account'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(thickness: 0.8),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LogoutPopup();
                                });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.logout_outlined),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Log Out'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
