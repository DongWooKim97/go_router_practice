

import 'package:go_router/go_router.dart';
import 'package:go_router_practice/screen/route_screen.dart';

// https://blog.codefactory.ai -> /하는거랑 같다. 도메인은 무시한다고 하면!!.  -> path
// 가정
final router = GoRouter(routes: [
  GoRoute(
    path: '/', // 첫 페이지
    builder:  (context, state)  {
      return RootScreen();
    }
  ),
]
    // 실제 인터넷에서 라우팅하듯 라우팅함
    ); //GoRouter 선언 , routes => 리스트를 넣자
