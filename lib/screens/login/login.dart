import 'package:footsie/components/primary_button.dart';
import 'package:footsie/constants.dart';
import 'package:footsie/screens/chats/chats_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _username = '', _password = '';

  @override
  void initState() {
    // TabController(vsync: true, length: 2);
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  Widget InputTextField(
    TextInputType keyboardType, {
    focusNode,
    controller,
    onChanged,
    decoration,
    bool obscureText = false,
  }) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding:
          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
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
    return InputTextField(
      TextInputType.text,
      controller: _usernameController,
      decoration: const InputDecoration.collapsed(
        hintText: "用户名",
      ),
      onChanged: (value) {
        setState(() {
          _username = value;
        });
      },
    );
  }

  Widget passwordInput() {
    return InputTextField(
      TextInputType.text,
      obscureText: true,
      controller: _passwordController,
      decoration: const InputDecoration.collapsed(
        hintText: "密码",
      ),
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget buildLogin() {
    return Column(
      children: [usernameInput(), passwordInput()],
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
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                ],
                controller: _tabController,
              ),

              //           TabBarView(
              // children: [
              //   buildLogin()
              // ],//用于切换的子控件列表，若要合TabBar一起使用注意和TabBar的长度一样
              // controller:,//控制器，若TabBar一起使用注意和TabBar使用同一个controller ，这样才能保证两者的联动关系
              // ), //??
              // ),
              Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
