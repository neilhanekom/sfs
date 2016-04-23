var Dashboard = angular.module('Dashboard', ['angular.morris-chart']);

Dashboard.controller('DashboardController', ['$scope', 
	function($scope) {
		$scope.welcome = 'Welcome to the angular Dashboard';
	}
]);