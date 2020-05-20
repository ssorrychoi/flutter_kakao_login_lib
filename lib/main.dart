import 'package:flutter/material.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Kakao Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterKakaoLogin kakaoSignIn = new FlutterKakaoLogin();
  String _nickName, _displayID, _accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kakao_login',
            ),
            SizedBox(
              height: 36,
            ),
            InkWell(
              child: Image.asset('assets/image/kakao.png'),
              onTap: () async {
                final KakaoLoginResult result = await kakaoSignIn.logIn();
                print(result.status);
                print(result.account.userEmail);
//                print(result.account.userNickname);
//                print(result.account.userDisplayID);
//                print(result.account.userAgeRange);
//                print(result.account.userBirthday);
//                print(result.account.userGender);
                print(result.account.userID);
//                print(result.account.userPhoneNumber);
                print('err : ${result.errorMessage}');
                _getAccessToken();
                print('kakao');
                print(
                    '===result===\n ${result.account.userNickname}\n${result.account.userDisplayID}');
                renewal(result);
              },
            ),
            SizedBox(
              height: 16,
            ),
            Text('UserId : ${_displayID}'),
            SizedBox(
              height: 16,
            ),
            Text('UserEmail : ${_nickName}'),
            SizedBox(
              height: 16,
            ),
            Text('accessToken : ${_accessToken}')
          ],
        ),
      ),
    );
  }

  Future<Null> _getAccessToken() async {
    final KakaoAccessToken accessToken = await (kakaoSignIn.currentAccessToken);
    if (accessToken != null) {
      final token = accessToken.token;
      print('gettoken : ${token}');
      setState(() {
        _accessToken = token;
      });
    }
  }

  void renewal(
    KakaoLoginResult result,
  ) {
    setState(() {
      _nickName = result.account.userEmail;
      _displayID = result.account.userID;
    });
  }
}
