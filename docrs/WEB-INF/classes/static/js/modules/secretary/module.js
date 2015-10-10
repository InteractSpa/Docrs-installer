
g_NG.controller('SecretaryController', function($scope, SecretaryService) {
	
    'use strict';
    
    var user = null;
    var selectedUserId = null;
    var selectedUser = null;
    
    angular.extend($scope, {
//    	selectedUser: getUser(selectedUserId),
    	users: getUsers(),
    	getSelectedUserId: function(id) {
        	selectedUserId = id;
        	return id;
        },
    	getUsers: function() {
			SecretaryService.getUsers().then(function(aData){
				$scope.users = aData;
				console.log(['aData in module', aData]);
			});
		},
		addUser: function() {
			SecretaryService.add($scope.user);
		},
		removeUser: function(id) {
			SecretaryService.removeUserById(id);
		}
    });
});

/* --- */

g_NG.service('SecretaryService', function($location, $q, $http) {

	var oService = angular.extend({}, {
        getUsers: function() {
        	var oDefer = $q.defer();
			$http.get('/' + instanceName + '/users/getAll?noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },
        add: function(oUser) {
			return $http.post('/' + instanceName + '/users/addUser', oUser).success(function(oResp){
				$location.path('/' + instanceName + '/anagrafica/listaUtenti');
			});
		}
    });
    return oService;
});
