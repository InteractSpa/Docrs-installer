g_NG.controller('ConvocationsController', function($scope, ConvocationsService, dayOrders, convocations, documents, convocation) {
    'use strict';
    angular.extend($scope, {

        convocations: convocations,
		convocation: convocation,

		documents: documents,
		dayOrders: dayOrders,

		currentUser: g_oUser,

		dayOrder: {
			id: -1,
			title: '',
			description: ''
		},

		canEdit: function(){
			return $scope.currentUser.systemRole == 'ADMIN' || $scope.currentUser.systemRole == 'SEGRETARY';
		},

		editDayOrder: function(oDayOrder) {
			$scope.dayOrder = {
				id: oDayOrder.id,
				title: oDayOrder.title,
				description: oDayOrder.description
			};
		},

		addNewDayOrd: function(){
			jQuery('#testModal').modal();
		},

		getAllDocuments: function() {
			var oDefer = $q.defer();
			$http.get('/' + instanceName + '/api/documents?noCache=' + new Date()).success(function(oResp) {
				if(oResp._embedded && oResp._embedded.documents){
					oDefer.resolve(oResp._embedded.documents);
				} else {
					oDefer.resolve([]);
				}
			}).error(function(){
				oDefer.reject();
			});
			return oDefer.promise;
        },

		removeDayOrderDocument: function(oDayOrder, oDoc)	{
			ConvocationsService.unlinkDayOrderDocument(oDayOrder.id, oDoc.id).success(function(oResp){
				oDayOrder.documents = oResp;
			});
		},


		removeConvocationDocument: function(oConvocationDocument) {
			ConvocationsService.unlinkConvocationDocument(oConvocationDocument.id).success(function(oResp){
				$scope.documents = oResp;
			});
		},
				
		addDocumentAsSessionSchedule: function(oConvocationDocument) {
			ConvocationsService.addSessionSchedule(oConvocationDocument.id).success(function(oResp){
				$scope.documents = oResp;
			});
		},
		
		removeDocumentAsSessionSchedule: function(oConvocationDocument) {
			ConvocationsService.removeSessionSchedule(oConvocationDocument.id).success(function(oResp){
				$scope.documents = oResp;
			});
		},

		addDayOrder: function() {
			ConvocationsService.saveConvocationDayOrder($scope.convocation, $scope.dayOrder).success(function(oResp){
				if($scope.dayOrders == null) {
					$scope.dayOrders = [];
				}
				if($scope.dayOrder.id && $scope.dayOrder.id > 0) {
					for(var i = 0; i < $scope.dayOrders.length; i++) {
						if($scope.dayOrders[i].id == $scope.dayOrder.id) {
							$scope.dayOrders[i].title = $scope.dayOrder.title;
							$scope.dayOrders[i].description = $scope.dayOrder.description;
							break;
						}
					}
				} else {
					$scope.dayOrders.push(oResp);
				}
				$scope.dayOrder = {
					id		: -1,
					title	: '',
					description: ''
				};
			});
		},

		deleteDayOrder: function(nId) {
			ConvocationsService.deleteConvocationDayOrder(nId).success(function(oResp){
				ConvocationsService.getConvocationDayOrders($scope.convocation.id).then(function(oData){
					$scope.dayOrders = oData;
				});
			});
		},

		save: function() {
			$scope.convocation.owner = g_oCurrentUser.uri;

			if($scope.convocation.start && $scope.convocation.starttime){
				$scope.convocation.start.setHours($scope.convocation.starttime.getHours());
				$scope.convocation.start.setMinutes($scope.convocation.starttime.getMinutes());
			}

			if($scope.convocation.end && $scope.convocation.endtime){
				$scope.convocation.end.setHours($scope.convocation.endtime.getHours());
				$scope.convocation.end.setMinutes($scope.convocation.endtime.getMinutes());
			}
			ConvocationsService.save($scope.convocation);
		},

		openStart: function($event) {
			$event.preventDefault();
			$event.stopPropagation();
			$scope.openedStart = true;
		},

		openEnd: function($event) {
			$event.preventDefault();
			$event.stopPropagation();
			$scope.openedEnd = true;
		},

		getConvocationId: function(oConvocation){
			if(oConvocation.id)
				return oConvocation.id;

			if(oConvocation._links
					&& oConvocation._links.self
					&& oConvocation._links.self.href){
				return oConvocation._links.self.href.substr(oConvocation._links.self.href.lastIndexOf('/') + 1);
			}
			return -1;
		},

		getWeekdayName: function(nTs){
			return ConvocationsService.getLocaleWeekdays()[new Date(nTs).getDay()];
		},

		initFileUpload: function() {
			jQuery('#fileupload').fileupload({
				formData: {
					id	 : $scope.convocation.id,
					type : 0
				},
				add: function (e, data) {
					var jqXHR = data.submit()
						//.success(function (result, textStatus, jqXHR) {console.log(result);})
						.error(function (jqXHR, textStatus, errorThrown) {console.log(jqXHR);})
						.complete(function (oResp, textStatus, jqXHR) {
							$scope.documents.push(oResp);
							$scope.$digest();
						});
				}
			});
		}
    });

	if($scope.convocation && $scope.convocation.id && $scope.convocation.id > 0){
		$scope.initFileUpload();
	}
});

/* --- */

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
			console.log('in convocation service');
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