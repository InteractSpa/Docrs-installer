g_NG.service('HomeService', function($q, $http) {

    var oService = angular.extend({}, {
        getEvents: function() {
			var oDefer = $q.defer();
            $http.get('/' + instanceName + '/convocation/getAllConvocations?noCache=' + new Date()).success(function(oResp){
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },
		getUser: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/user?noCache=' + new Date()).success(function(oResp){
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
		}
    });

	function getConvocationId(oConvocation){
		if(oConvocation._links
				&& oConvocation._links.self
				&& oConvocation._links.self.href){
			return oConvocation._links.self.href.substr(oConvocation._links.self.href.lastIndexOf('/') + 1);
		}
		return -1;
	}

    return oService;
});