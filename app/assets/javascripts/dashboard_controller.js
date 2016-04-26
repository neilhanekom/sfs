var Dashboard = angular.module('Dashboard', ['angular.morris-chart', 'ngRoute', 'templates']);

Dashboard.config(['$routeProvider',
	function($routeProvider) {
		$routeProvider.when("/", {
		controller: "DashboardController",
		templateUrl: "dashboards/dashboard.html"
	});
}
]);

Dashboard.controller('DashboardController', ['$scope', '$location',
	function($scope, $location) {
		$scope.welcome = 'Welcome to the angular Dashboard';
	}
]);