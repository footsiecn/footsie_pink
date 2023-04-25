import 'package:footsie/components/primary_button.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _username = '', _password = '';

  Widget InputTextField(
    TextInputType keyboardType, {
    focusNode,
    controller,
    onChanged,
    decoration,
    bool obscureText = false,
    height = 50.0,
  }) {
    return Container(
      height: height,
      margin: EdgeInsets.all(10.0),
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
          Divider(
            height: 1.0,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget usernameInput() {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black12,
        ),
        alignment: Alignment.center,
        child: InputTextField(
          TextInputType.number,
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "用户名",
            border: InputBorder.none,
            //使用 GestureDetector 实现手势识别
            suffixIcon: GestureDetector(
              child: Offstage(
                offstage: _username == '',
                child: Icon(Icons.clear),
              ),
              //点击清除文本框内容
              onTap: () {
                setState(() {
                  _username = '';
                  _usernameController.clear();
                });
              },
            ),
          ),
          //使用 onChanged 完成双向绑定
          onChanged: (value) {
            setState(() {
              _username = value;
            });
          },
        ));
  }

  Widget passwordInput() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
      alignment: Alignment.center,
      child: InputTextField(
        TextInputType.text,
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          hintText: "密码",
          suffixIcon: GestureDetector(
            child: Offstage(
              offstage: _password == '',
              child: const Icon(Icons.clear),
            ),
            onTap: () {
              setState(() {
                _password = '';
                _passwordController.clear();
              });
            },
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                "assets/images/footsie-logo.png",
                height: 120,
              ),
              const Spacer(),
              Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  usernameInput(),
                  passwordInput(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
              PrimaryButton(
                text: "登录",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatsScreen(),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "注册",
                press: () {},
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
