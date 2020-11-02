import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
export 'route_paths.dart';

import '../components/login_component/login_component.template.dart' as login_template;

import '../components/painel_component/painel_component.template.dart' as painel_template;

import '../components/not_found_component/not_found_component.template.dart' as notfound_template;


class Routes {
  static final login = RouteDefinition(
    routePath: RoutePaths.login,
    component: login_template.LoginComponentNgFactory
  );

  static final painel = RouteDefinition(
    routePath: RoutePaths.painel,
    component: painel_template.PainelComponentNgFactory
    //PainelComponentNgFactory
  );  

  static final notfound = RouteDefinition(
    routePath: RoutePaths.notfound,
    component: notfound_template.NotFoundComponentNgFactory
  );  

  static final all = <RouteDefinition>[
    login,
    painel,
    notfound,
    RouteDefinition.redirect(
      path: '',
      redirectTo: RoutePaths.login.toUrl(),
    ), 
    RouteDefinition.redirect(
      path: '.+',
      redirectTo: RoutePaths.notfound.toUrl(),
    ),         
  ];
}
