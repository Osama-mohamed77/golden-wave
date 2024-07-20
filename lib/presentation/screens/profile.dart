import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.purple),
        height: double.infinity,
        width: double.infinity,
        child: IconButton(
            onPressed: () {
              Provider.of<AuthProviderOS>(context, listen: false).signOut();
              Navigator.pushNamed(context, SignIn.id);
            },
            icon: const Icon(
              Icons.logout,
              size: 50,
              color: MyColors.myWhite,
            )),
      ),
    );
  }
}
