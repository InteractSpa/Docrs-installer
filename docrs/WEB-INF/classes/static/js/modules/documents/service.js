g_NG.service('DocumentsService', function($q, $http) {

    var oService = angular.extend({}, {
		linkDayOrderDocument: function(nId, nDocId, sType) {
			return $http.get('/' + instanceName + '/convocation/dayOrder/' + nId + '/document/' + nDocId + '/add/?noCache=' + new Date());
		},

		linkConvocationDocument: function(nId, nDocId) {
			return $http.get('/' + instanceName + '/convocation/' + nId + '/document/' + nDocId + '/add?noCache=' + new Date());
		},

        getDocuments: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/allActive?noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		removeTag: function(oDocument, sName) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/tag/remove?documentId=' + oDocument.id + '&name=' + sName + '&noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		addTag: function(oDocument, sName) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/tag/add?documentId=' + oDocument.id + '&name=' + sName + '&noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		getPreferedDocuments: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/prefered/list?noCache=' + new Date()).success(function(oResp) {
				for(var i = 0; i < oResp.length; i++) {
					oResp[i].prefered = true;
				}
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		addDocumentToPrefered: function(nId) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/user/prefered/add?id=' + nId + '&noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		getConvocationDocuments: function(oConvocation) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/convocation?id=' + oConvocation.id + '&noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
		},

		getConvocations: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/convocation/getAllConvocations?noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		searchDocuments: function(sSearch) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/search?search=' + sSearch + '&noCache=' + new Date()).success(function(oResp) {
				oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		deleteDocument: function(oDocument) {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/documents/delete?id=' + oDocument.id + '&noCache=' + new Date()).success(function(oResp) {
				console.log('Deleted Doc:', oResp);
				oDocument.deleted = true;
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		getPrivateDocuments: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/api/documents?type=PRIVATE?noCache=' + new Date()).success(function(oResp) {
				console.log('Docs:', oResp);
				if(oResp._embedded && oResp._embedded.documents){
					oDefer.resolve(oResp._embedded.documents);
				} else {
					oDefer.resolve([]);
				}
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        }
    });
    return oService;
});