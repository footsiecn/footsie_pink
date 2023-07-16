import 'package:footsie/api.dart';
import 'package:footsie/components/primary_button.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:footsie/util/toast_util.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String name = '', pwd = '', email = '';

  @override
  void initState() {
    // TabController(vsync: true, length: 2);
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget inputTextField(
    TextInputType keyboardType, {
    focusNode,
    controller,
    onChanged,
    decoration,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
      child: Column(
        children: [
          TextField(
            keyboardType: keyboardType,
            focusNode: focusNode,
            obscureText: obscureText,
            controller: controller,
            decoration: decoration,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget usernameInput() {
    return inputTextField(
      TextInputType.text,
      decoration: const InputDecoration.collapsed(
        hintText: "用户名",
      ),
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget passwordInput() {
    return inputTextField(
      TextInputType.text,
      obscureText: true,
      decoration: const InputDecoration.collapsed(
        hintText: "密码",
      ),
      onChanged: (value) {
        setState(() {
          pwd = value;
        });
      },
    );
  }

  Widget buildLogin() {
    return Column(
      children: [usernameInput(), passwordInput()],
    );
  }

  Widget buildRegister() {
    return const Center(
      child: Text("注册"),
    );
  }

  _login(context) async {
    final res = jsonDecode((await login({'name': name, 'pwd': pwd})).data);

    if (res['code'] != 200) {
      showErrorSnackBar(res['msg']);
    } else {
      Instances.sp.setString('usertoken', res['data']['token']);
      Instances.sp.setString('userinfo', jsonEncode(res['data']['user']));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              TabBar(
                indicator: const BoxDecoration(),
                tabs: const [
                  Tab(
                    text: "登录",
                  ),
                  Tab(text: "注册"),
                ],
                controller: _tabController,
              ),
              Expanded(
                child: TabBarView(
                  children: [buildLogin(), buildRegister()],
                  controller: _tabController,
                ),
              ),
              PrimaryButton(
                  text: "登录",
                  press: () {
                    _login(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
