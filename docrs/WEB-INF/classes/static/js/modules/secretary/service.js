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
		},
		removeUserById: function(id) {
			console.log('in service');
			return $http.get('/' + instanceName + '/users/delete/'+ id +'/?noCache=' + new Date());
		}
    });
    return oService;
});