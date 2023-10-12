import 'package:go_router/go_router.dart';
import 'package:go_router_practice/screen/1_basic_screen.dart';
import 'package:go_router_practice/screen/route_screen.dart';

//GoRouter 선언 , routes => 리스트를 넣자
// https://blog.codefactory.ai -> /하는거랑 같다. 도메인은 무시한다고 하면!!.  -> path
final router = GoRouter(
  routes: [
    GoRoute(
      //라우터 등록
      path: '/', // 첫 페이지
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        // ★ route 속 routes -> 중첩된 url 관리하기 위함.!!
        GoRoute(
          path: 'basic',
          builder: (context, builder) {
            return BasicScreen();
          },
        ),
      ],
    ),
  ],
);

// / -> home
// /basic -> basic screen
