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

Customers.controller('CustomerController', ['$scope', '$http', '$location', '$routeParams', 'Customer',
	function($scope, $http, $location, $routeParams, Customer) {
		

			var customerId = $routeParams.id;
			// Customer.get(customerId).then(function (customer) {
		 //        $scope.customer = customer;
		 //    });

			$http.get(
			"/customers/" + customerId + ".json"
			).then(function(response) { $scope.customer = response.data;
			},function(response) {
			alert("There was a problem: " + response.status);
			} );

			$scope.view_edit = false;
			$scope.toggleViewEdit = function() {
				$scope.view_edit = !$scope.view_edit;
				console.log($scope.view_edit);
			};

			$scope.update = function(customer) {
			console.log("updating");
			var update_cust = new Customer({
				id: customer.id,
				f_name: customer.f_name,
				l_name: customer.l_name,
				rsaid: customer.rsaid,
				phone: customer.phone,
				neigbour: customer.neigbour
			});

			update_cust.update().then(function(response){
				console.log(response);
				$scope.view_edit = false;
			}, function(erro) {
				console.log(error);
			});
		};

			
		
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
