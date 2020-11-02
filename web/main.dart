import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:carros/app_component.template.dart' as ng;
import 'package:http/http.dart';
import 'main.template.dart' as self;
import 'package:carros/src/services/carro_service_in_memory.dart';


@GenerateInjector([
  routerProvidersHash, // You can use routerProviders in production
  ClassProvider(Client, useClass: InMemoryDataService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
