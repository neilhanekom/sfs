var Loans = angular.module('Loans', ['ngRoute', 'templates', 'rails']);

Loans.factory('Loan', ['railsResourceFactory', function (railsResourceFactory) {
    return railsResourceFactory({url: '/loans', name: 'loan'});
}]);

Loans.config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

Loans.config([
	"$routeProvider",
	function($routeProvider) {
		$routeProvider.when("/", {
		controller: "LoansController",
		templateUrl: "loans/index.html"
	}).when("/new", {
		controller: "newLoanController",
		templateUrl: "loans/newloan.html"
	}).when("/:id", {
		controller: "LoanController",
		templateUrl: "loans/loan.html"
	});
	}

]);

Loans.controller('LoansController', ['$scope', '$http', '$location',
	function($scope, $http, $location) {
		$scope.TestMessage = "Welcome to Loans Angular";

		$scope.search = function(searchTerm) {

			$http.get("/loans.json",
				{ "params": { "keywords": searchTerm } }
				).then(function(response) {
					$scope.loans = response.data;
				},function(response) {
					alert("There was a problem: " + response.status);
				}
			);
		};

		$scope.viewDetails = function(loan) {
			$location.path("/" + loan.id);
		};

		
	}
]);

Loans.controller('LoanController', ['$scope', '$http', '$location', '$routeParams', 'Loan',
	function($scope, $http, $location, $routeParams, Loan) {
		

			var loanId = $routeParams.id;
			// Loan.get(loanId).then(function (loan) {
		 //        $scope.loan = loan;
		 //    });

			$http.get(
			"/loans/" + loanId + ".json"
			).then(function(response) { $scope.loan = response.data;
			},function(response) {
			alert("There was a problem: " + response.status);
			} );

			$scope.view_edit = false;
			$scope.toggleViewEdit = function() {
				$scope.view_edit = !$scope.view_edit;
				console.log($scope.view_edit);
			};

			$scope.update = function(loan) {
			console.log("updating");
			var update_cust = new Loan({
				id: loan.id,
				f_name: loan.f_name,
				l_name: loan.l_name,
				rsaid: loan.rsaid,
				phone: loan.phone,
				neigbour: loan.neigbour
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

Loans.controller('newLoanController', ['$scope', '$http', '$location', '$routeParams', 'Loan',
	function($scope, $http, $location, $routeParams, Loan) {
		
		$scope.testMessage = "Hi!!"

		$scope.create = function(loan) {
			var new_cust = new Loan({
				f_name: loan.f_name,
				l_name: loan.l_name,
				rsaid: loan.rsaid,
				phone: loan.phone,
				neigbour: loan.neigbour
			});

			new_cust.create();
			
		};


		}
]);