g_NG.service('ConvocationsService', function($location, $q, $http) {
	var g_aWeekDays = [
		'Domenica',
		'Lunedí',
		'Martedí',
		'Mercoledí',
		'Giovedí',
		'Venerdí',
		'Sabato'
	];

    var oService = angular.extend({}, {
        getConvocations: function() {
			var oDefer = $q.defer();
            $http.get('/' + instanceName + '/convocation/getAllConvocations?noCache=' + new Date()).success(function(oResp){
            	oDefer.resolve(oResp);
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		getLocaleWeekdays: function() {
			return g_aWeekDays;
		},

		unlinkDayOrderDocument: function(nDayOrderId, nDocId) {
			return $http.get('/' + instanceName + '/convocation/dayOrder/' + nDayOrderId + '/document/' + nDocId + '/remove?noCache=' + new Date());
		},

		unlinkConvocationDocument: function(nConvocationDocumentId) {
			return $http.get('/' + instanceName + '/convocation_document/' + nConvocationDocumentId + '/remove?noCache=' + new Date());
		},
		
		addSessionSchedule: function(nConvocationDocumentId) {
			return $http.get('/' + instanceName + '/convocation_document/' + nConvocationDocumentId + '/setAsSessionSchedule?noCache=' + new Date());
		},
		
		removeSessionSchedule: function(nConvocationDocumentId) {
			return $http.get('/' + instanceName + '/convocation_document/' + nConvocationDocumentId + '/removeAsSessionSchedule?noCache=' + new Date());
		},

		save: function(oConvocation) {
			//console.log(oConvocation);
			/*delete oConvocation.endtime;
			delete oConvocation.starttime;
			delete oConvocation.owner;
			oConvocation.sessionId = '';*/
			if(oConvocation.publish == null) {
				oConvocation.publish = false;
			}
			return $http.post('/' + instanceName + '/convocation/save', oConvocation).success(function(oResp){
				$location.path('/' + instanceName + '/convocations');
			});
		},

		getConvocationDayOrders: function(nId) {
			return oService.getConvocation(nId);
		},

		saveConvocationDayOrder: function(oConvocation, oDayOrder) {
			return $http.post('/' + instanceName + '/convocation/' + oConvocation.id + '/dayOrder/save', oDayOrder).success(function(oResp){
				//$location.path('/convocations');
			});
		},

		deleteConvocationDayOrder: function(nId) {
			return $http.post('/' + instanceName + '/convocation/dayOrder/' + nId + '/delete').success(function(oResp){
			});
		},

		getConvocationDayOrders: function(nConvocationId) {
			var oDefer = $q.defer();
			if(nConvocationId <= 0) {
				oDefer.resolve([]);
			} else {
				$http.get('/' + instanceName + '/convocation/' + nConvocationId + '/dayOrder/list?noCache=' + new Date()).success(function(oResp) {
					oDefer.resolve(oResp);
				}).error(function(){
					oDefer.reject();
				});
			}
			return oDefer.promise;
		},

		getConvocationDocuments: function(nId) {
			var oDefer = $q.defer();
			if(nId <= 0) {
				oDefer.resolve([]);
			} else {
				$http.get('/' + instanceName + '/convocation/' + nId + '/documents?noCache=' + new Date()).success(function(oResp) {
					if(oResp){
						oDefer.resolve(oResp);
					} else {
						oDefer.resolve([]);
					}
				}).error(function(){
					oDefer.reject();
				});
			}
			return oDefer.promise;
		},

		getConvocation: function(nId) {
            var oDefer = $q.defer();
				if(nId <= 0) {
					var oStart = new Date();
						oStart.setMinutes(0);
					var oEnd = new Date();
						oEnd.setMinutes(15);
					oDefer.resolve({
						start: oStart,
						starttime: oStart,
						end: oEnd,
						endtime: oEnd
					});
				} else {
					$http.get('/' + instanceName + '/convocation/' + nId + '/detail?noCache=' + new Date()).success(function(oResp) {
						oResp.id = nId;
						oResp.start		= new Date(oResp.start);
						oResp.end		= new Date(oResp.end);
						oResp.starttime = oResp.start;
						oResp.endtime	= oResp.end;
						console.log(oResp);
						oDefer.resolve(oResp);
					}).error(function(){
						oDefer.reject();
					});
				}
			return oDefer.promise;
        }
    });
    return oService;
});