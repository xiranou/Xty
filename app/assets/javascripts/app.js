var app = angular.module('fanslu', ['ngRoute', 'ngResource', 'controllers']);


//Setup correct headers
angular.module('fanslu').run(['$http', function($http) {
  $http.defaults.headers.common['Accept'] = 'application/json';
  $http.defaults.headers.common['Content-Type'] = 'application/json';
}]);

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode({enabled: true, requireBase: false});
  $locationProvider.hashPrefix('!');
  $routeProvider
  .when("/", {
    templateUrl: "templates/home.html",
    controller: "HomeController"
  });
}]);



var controllers = angular.module('controllers',[])

//Home Controller
controllers.controller("HomeController", ['$scope','$location','$http', function($scope, $location, $http){

}])