var Customers = angular.module('Customers', ['ngRoute', 'templates', 'rails']);

Customers.factory('Customer', ['railsResourceFactory', function (railsResourceFactory) {
    return railsResourceFactory({url: '/customers', name: 'customer'});
}]);

Customers.config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

Customers.config([
	"$routeProvider",
	function($routeProvider) {
		$routeProvider.when("/", {
		controller: "CustomersController",
		templateUrl: "customers/customers.html"
	}).when("/new", {
		controller: "newCustomerController",
		templateUrl: "customers/newcustomer.html"
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

Customers.controller('CustomerController', ['$scope', '$http', '$location', '$routeParams', '$resource',
	function($scope, $http, $location, $routeParams, $resource) {
		

			var customerId = $routeParams.id;
			var Customer = $resource('/customers/:customerId.json')

			$scope.customer = Customer.get({ "customerId": customerId});
		
	}
]);

Customers.controller('newCustomerController', ['$scope', '$http', '$location', '$routeParams', 'Customer',
	function($scope, $http, $location, $routeParams, Customer) {
		
		$scope.testMessage = "Hi!!"

		$scope.create = function(customer) {
			var new_cust = new Customer({
				f_name: customer.f_name,
				l_name: customer.l_name,
				rsaid: customer.rsaid,
				phone: customer.phone,
				neigbour: customer.neigbour
			});

			new_cust.create();
		};
			
	
		}
]);
