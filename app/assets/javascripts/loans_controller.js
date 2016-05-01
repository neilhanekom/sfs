var Loans = angular.module('Loans', ['ngRoute', 'templates', 'rails', 'ui.bootstrap']);

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

			update_cusupdate().then(function(response){
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
		$scope.loan = {};
		
		$scope.salesreps = [
			{ f_name: "John", l_name: "Smit", id: 1 },
			{ f_name: "Han", l_name: "Sole", id: 2 },
			{ f_name: "Michael", l_name: "Jackson", id: 3 },
			{ f_name: "Jesse", l_name: "James", id: 4 }
		];

		$scope.formatDate = function(date) {
			
			// var loan_d = new Date(date);
			$scope.loan.loan_date = moment(date).format("YYYY-MM-DD");
			console.log($scope.loan)
		};

		$scope.addRep = function(salesrep) {
			$scope.loan.salesrep = parseInt(salesrep);
		};

		$scope.calcLoan = function(loanAmount) {
			$scope.loan.admin_fee = loanAmount * 0.3;
			$scope.loan.total_amount = loanAmount + $scope.loan.admin_fee;
		};

		$scope.finalpaydate = function(date, installments) {
			if (date && installments) {
				$scope.loan.final_payment_date = moment(date).add(installments, 'months').format("YYYY-MM-DD");
			}

			console.log($scope.loan);
			
		};


		$scope.searchCustomer = function(searchTerm) {
			$scope.customer = undefined;
			$http.get("/customers.json",
				{ "params": { "keywords": searchTerm } }
				).then(function(response) {
					$scope.customers = response.data;
				},function(response) {
					alert("There was a problem: " + response.status);
				}
			);
		};

		$scope.AddCustomer = function(customer) {
			$scope.customer = customer;
			$scope.loan.customer = customer.id;
			$scope.customers = [];
			$scope.keywords = '';


		};

		$scope.create = function(loan) {
			
			var new_loan = new Loan({
				loan_date: loan.loan_date,
		    	agreement_no: loan.agreement_no,
		    	salesrep_id: loan.salesrep,
		    	customer_id: loan.customer,
		    	loan_amount: loan.loan_amount,
		    	admin_fee: loan.admin_fee,
		    	total_amount: loan.total_amount,
		    	balance: loan.total_amount,
		    	installments: loan.installments,
		    	final_payment_date: loan.final_payment_date
			});

			console.log(new_loan);

			new_loan.create();

		};





		}
]);