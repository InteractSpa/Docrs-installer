var g_NG = angular.module('main', ['ngRoute', 'ui.bootstrap', 'ui.calendar','treeRepeat.directives']);

var instanceName = "docrs";

var g_oCurrentUser = {
	id: 1,
	uri: 'http://localhost:8080/api/users/1'
};

var g_oUser = {
		role: ''
};
$.ajax({url:'/' + instanceName + '/user',success:function(oResp){g_oUser = oResp;}});
	
function httpGet(theUrl) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false );
    xmlHttp.send( null );
    return xmlHttp.responseText;
}

function getUsers() {
	return JSON.parse(httpGet('/' + instanceName + '/users/getAll?noCache=' + new Date()));
}

function deleteUser(id) {
	console.log("Utente "+ id + "Eliminato");
	alert("Utente "+ id + "Eliminato");
	//httpGet('/' + instanceName + '/users/delete/'+ id +'?noCache=' + new Date());
}

function getUser(id) {
	return JSON.parse(httpGet('/' + instanceName + '/users/get/' + id + '?noCache=' + new Date()));
}

function MyCtrl($scope, $location) { 
    $scope.deleteUser = function(userId) {
    	deleteUser(userId);
    	alert("Utente Eliminato!");
    	$location.path('./views/modules/anagrafica/listaUtenti.html?noCache=' + new Date());
    }
    function deleteUser(id) {
    	httpGet('/' + instanceName + '/users/delete/'+ id +'?noCache=' + new Date());
    }
}

g_NG.config(function($routeProvider) {
	$routeProvider
		.when('/', {
			controller: 'HomeController',
			templateUrl: './views/modules/home/module.html?noCache=' + new Date(),
            resolve: {
				events: function(HomeService){
					return HomeService.getEvents();
				}
			}
		})
		.when('/users', {
			controller: 'UsersController',
			templateUrl: './views/modules/users/module.html?noCache=' + new Date(),
			resolve: {
				user: function() {
					// do nothing
				}
			}
		})
		.when('/documents', {
			controller: 'DocumentsController',
			templateUrl: './views/modules/documents/module.html?noCache=' + new Date(),
			resolve: {
				documents: function(DocumentsService){
					return DocumentsService.getDocuments();
				},
				convocations: function(DocumentsService){
					return DocumentsService.getConvocations();
				}
			}
		})
		.when('/documents/convocation/:convocationId', {
			controller: 'DocumentsController',
			templateUrl: './views/modules/documents/module.html?noCache=' + new Date(),
			resolve: {
				documents: function(DocumentsService){
					return DocumentsService.getDocuments();
				},
				convocations: function(DocumentsService){
					return DocumentsService.getConvocations();
				}
			}
		})
		.when('/documents/convocation/:convocationId/:type', {
			controller: 'DocumentsController',
			templateUrl: './views/modules/documents/module.html?noCache=' + new Date(),
			resolve: {
				documents: function(DocumentsService){
					return DocumentsService.getDocuments();
				},
				convocations: function(DocumentsService){
					return DocumentsService.getConvocations();
				}
			}
		})
		.when('/documents/dayOrder/:dayOrderId', {
			controller: 'DocumentsController',
			templateUrl: './views/modules/documents/module.html?noCache=' + new Date(),
			resolve: {
				documents: function(DocumentsService){
					return DocumentsService.getDocuments();
				},
				convocations: function(DocumentsService){
					return DocumentsService.getConvocations();
				}
			}
		})
		.when('/users/:id/detail', {
			controller: 'UsersController',
			templateUrl: './views/modules/users/detail.html?noCache=' + new Date(),
			resolve: {
				user: function($route, UsersService) {
					return UsersService.getUserDetails($route.current.params.id);
				}
			}
		})
		.when('/convocations', {
			controller: 'ConvocationsController',
			templateUrl: './views/modules/convocations/module.html?noCache=' + new Date(),
			resolve: {
				convocations: function($route, ConvocationsService) {
					return ConvocationsService.getConvocations();
				},
				documents: function(){
					return null;
				},
				convocation: function(){
					return null;
				},
				dayOrders: function() {
					return null;
				}
			}
		})
		.when('/convocations/:id/edit', {
			controller: 'ConvocationsController',
			templateUrl: './views/modules/convocations/edit.html?noCache=' + new Date(),
			resolve: {
				convocation: function($route, ConvocationsService) {
					return ConvocationsService.getConvocation($route.current.params.id);
				},
				documents: function($route, ConvocationsService) {
					return ConvocationsService.getConvocationDocuments($route.current.params.id);
				},
				convocations: function(){
					return null;
				},
				dayOrders: function($route, ConvocationsService) {
					return ConvocationsService.getConvocationDayOrders($route.current.params.id);
				}
			}
		})
		.when('/convocations/:convocationId/dayOrder/:dayOrderId/documents', {
			controller: 'ConvocationsController',
			templateUrl: './views/modules/convocations/documents.html?noCache=' + new Date(),
			resolve: {
				convocation: function() {
					return null;
				},
				documents: function(ConvocationsService) {
					return ConvocationsService.getAllDocuments();
				},
				convocations: function(){
					return null;
				},
				dayOrders: function() {
					return null;
				}
			}
		})
		.when('/convocations/:id/view', {
			controller: 'ConvocationsController',
			templateUrl: './views/modules/convocations/view.html?noCache=' + new Date(),
			resolve: {
				convocation: function($route, ConvocationsService) {
					return ConvocationsService.getConvocation($route.current.params.id);
				},
				documents: function($route, ConvocationsService) {
					return ConvocationsService.getConvocationDocuments($route.current.params.id);
				},
				convocations: function(){
					return null;
				},
				dayOrders: function($route, ConvocationsService) {
					return ConvocationsService.getConvocationDayOrders($route.current.params.id);
				}
			}
		})
		.when('/anagrafica', {
			templateUrl: './views/modules/anagrafica/anagrafica.html?noCache=' + new Date()
		})
		.when('/anagrafica/nuovoUtente', {
			controller: 'SecretaryController',
			templateUrl: './views/modules/anagrafica/nuovoUtente.html?noCache=' + new Date(),
		})
		.when('/anagrafica/listaUtenti', {
			controller: 'SecretaryController',
			templateUrl: './views/modules/anagrafica/listaUtenti.html?noCache=' + new Date(),
			resolve: {
			}
		})
		.otherwise({
			redirectTo: '/'
		});
});


g_NG.controller('MenuController', function($scope, $location, HomeService) {
	'use strict';

	angular.extend($scope, {
		user: null,
		menuItems: [
			{
				url: '/',
				label: 'Agenda',
				icon: 'fa-calendar',
				target: '_self',
				active: true
			},{
				url: '/convocations',
				label: 'Convocazioni',
				target: '_self',
				icon: 'fa-list'
			},{
				url: '/documents',
				icon: 'fa-briefcase',
				target: '_self',
				label: 'Documenti'
			},{
				url: 'http://videoassemblea.it',
				icon: 'fa-video-camera',
				target: '_blank',
				label: 'Videoassemblea'
			},{
				url: '/' + instanceName + '/logout',
				isRelative: true,
				icon: 'fa-lock',
				target: '_self',
				label: 'Logout'
			}
		],

		/**
		 * This method returns the class name 'active' if the menu item is active
		 * @param {type} oItem menu item element
		 * @returns {String}
		 */
		isActive: function(oItem) {
			return oItem.active ? 'active' : '';
		},

		getCurrentUser: function(){
			HomeService.getUser().then(function(oUser){
				$scope.user = oUser;
			});
		},

		/**
		 * Prepends the hash '#' to the URL
		 * @param {type} oItem menu item element
		 * @returns {String}
		 */
		getURL: function(oItem) {
			if(!oItem.isRelative) {
				if(oItem.url.substr(0,4) == 'http'){
					return oItem.url;
				} else
					return '#' + oItem.url;
			} else {
				return oItem.url;
			}
		},
		getInstanceName: function () {
			return instanceName;
		},
		getPostUrl: function () {
			return '/' + instanceName + '/login';
		},

		/**
		 * This method is invoked after the hash URL change by the "$routeChangeStart".
		 * It sets all menu items 'active' to false except the selected one.
		 * @param {type} sSelectedPath the URL of the selected menu item, without the hash '#'
		 * @returns void
		 */
		resetSelectedMenuItem: function(sSelectedPath) {
			$scope.menuItems.forEach(function(oMenuItem) {
				oMenuItem.active = oMenuItem.url === sSelectedPath;
			});
		}
	});	

	$scope.$on('$routeChangeStart', function(oNext, oCurrent) {
		$scope.resetSelectedMenuItem($location.path());
	});

	$scope.$on('$routeChangeError', function(oEvt, oCurrent, oPrev, sReject) {
		console.log('$routeChangeError: %o', sReject);
	});
	$scope.getCurrentUser();
});