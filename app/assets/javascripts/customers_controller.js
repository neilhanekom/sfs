var Customers = angular.module('Customers', ['ngRoute', 'templates']);

Customers.config([
	"$routeProvider",
	function($routeProvider) {
		$routeProvider.when("/", {
		controller: "CustomersController",
		templateUrl: "customers/customers.html"
	}).when("/:id", {
		controller: "CustomerController",
		templateUrl: "customers/customer.html"
	});
	}
]);

Customers.controller('CustomersController', ['$scope', '$http', '$location',
	function($scope, $http, $location) {
		$scope.TestMessage = "Welcome to Customers Angular";

		$scope.search = function(searchTerm) {

			$http.get("/customers.json",
				{ "params": { "keywords": searchTerm } }
				).then(function(response) {
					$scope.customers = response.data;
				},function(response) {
					alert("There was a problem: " + response.status);
				}
			);
		};

		$scope.viewDetails = function(customer) {
			$location.path("/" + customer.id);
		};
	}
]);

Customers.controller('CustomerController', ['$scope', '$http', '$location', '$routeParams',
	function($scope, $http, $location, $routeParams) {
		

		// $scope.search = function(searchTerm) {

			var customerId = $routeParams.id;
			$scope.customer = {};
			$http.get("/customers/" + customerId + ".json").then(function(response) {
				$scope.customer = response.data;
			},function(response) {
				alert("There was a problem: " + response.status);
			});
		

		
	}
]);