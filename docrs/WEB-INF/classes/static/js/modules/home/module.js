g_NG.controller('HomeController', function($location, $locale, $scope, events) {
	'use strict';
	
	$scope.dayClickEvent = function(oDate, oEvent, oView) {
		console.log('Click: %o %o %o', oDate, oEvent, oView);
	};

	$scope.eventClickEvent = function(oCalEvent, oEvent, oView) {
		$location.path('convocations/' + oCalEvent.id + '/view');
	};

	$scope.eventDropEvent = function(oCalEvent, oDelta, oRevertFunc, oEvent) {
		console.log('Drop: %o %o %o %o', oCalEvent, oDelta, oRevertFunc, oEvent);
	};

	function getConvocationId(oConvocation) {
		if(oConvocation.id){
			return oConvocation.id;
		}
		if(oConvocation._links
				&& oConvocation._links.self
				&& oConvocation._links.self.href){
			return oConvocation._links.self.href.substr(oConvocation._links.self.href.lastIndexOf('/') + 1);
		}
		return -1;
	}

	angular.extend($scope, {
		uiConfig: {
			lang: 'it',
			calendar: {
				height: 550,
				editable: true,
				firstHour: 8,
				firstDay: 1,
				ignoreTimezone: false,
				header: {
					left: 'month agendaWeek agendaDay',
					center: 'title',
					right: 'prev,next'
				},
				dayClick: $scope.dayClickEvent,
				eventClick: $scope.eventClickEvent,
				eventDrop: $scope.eventDropEvent,
				eventResize: $scope.alertOnResize,
				eventRender: function(oEvent, oEventElement, oMonthView) {
					//console.log('oEvent', oEvent.start._i);
					var oDate = new Date(oEvent.start._i);
					oEventElement.attr('title', "Clicca per visualizzare");
					oEventElement.empty();
					var sTitle = '';//oDate.getHours() + ':' + oDate.getMinutes();
					oEventElement.append($('<span>' + sTitle + ' ' + oEvent.title + '</span>'));
					return false;
				}
			}
		},

		eventsSource: {
			events: events
		}
	});
});

/* --- */

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