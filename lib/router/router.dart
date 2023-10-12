import 'package:go_router/go_router.dart';
import 'package:go_router_practice/screen/1_basic_screen.dart';
import 'package:go_router_practice/screen/2_named_screen.dart';
import 'package:go_router_practice/screen/3_push_screen.dart';
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
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, builder) {
            return NamedScreen();
          }, // name 파라미터를 이용해서 라우터를 이동할 수 있다 .url이 길어졌을 때 (= url을 찾기 힘들어졌을때!)유용!
        ),
        GoRoute(
          path: 'push',
          builder: (context, builder) {
            return PushScreen();
          }, // name 파라미터를 이용해서 라우터를 이동할 수 있다 .url이 길어졌을 때 (= url을 찾기 힘들어졌을때!)유용!
        ),
      ],
    ),
  ],
);

// / -> home
// /basic -> basic screen
// /named
// /push
