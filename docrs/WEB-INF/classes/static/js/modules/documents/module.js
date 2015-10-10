g_NG.controller('DocumentsController', function($scope, $window, $route, documents, convocations,DocumentsService) {
	'use strict';
	//console.log('Convooc: ', $route.current.params.convocationId);
	//console.log('DayOrd: ', $route.current.params.dayOrderId);
	console.log('$route: ', $route);
	angular.extend($scope, {
		documents: documents,
		convocations: convocations,
		documentType: null,
		searchText: '',

		currentUser: g_oUser,

		documentTypes: [
		                {name: 'Public', value: 'PUBLIC'},
		                {name: 'Private', value: 'PRIVATE'}
		                ],

		                searchDocuments: function($event){
//		                	if ($event.which === 13 && $scope.searchText.length > 3) {
		                	if ($event.which == 13) {
		                		DocumentsService.searchDocuments($scope.searchText).then(function(aData){
		                			$scope.documents = aData;
		                		});
		                		console.log('testo cercato' + $scope.searchText);
		                	}
		                },

		                addTag: function(oDocument) {
		                	var sName = prompt("Digita il nome del TAG");
		                	DocumentsService.addTag(oDocument, sName).then(function(oTag){
		                		if(!oDocument.tags) {
		                			oDocument.tags = [];
		                		}
		                		oDocument.tags.push(oTag);
		                	});
		                },

		                removeTag: function(oDocument, oTag) {
		                	DocumentsService.removeTag(oDocument, oTag.name).then(function(oResp){
		                		oDocument.tags = oResp.tags;
		                	});
		                },

		                showConvocationDocuments: function(oConvocation) {
		                	// Empty the search text
		                	$scope.searchText = '';
		                	DocumentsService.getConvocationDocuments(oConvocation).then(function(aData){
		                		$scope.documents = aData;
		                	});
		                },

		                addDocumentToPrefered: function(oDoc){
		                	oDoc.prefered = true;
		                	DocumentsService.addDocumentToPrefered(oDoc.id).then(function(oDoc){
		                		//console.log('DONE', oDoc);
		                	});
		                },

		                showPreferedDocuments: function() {
		                	DocumentsService.getPreferedDocuments().then(function(aData){
		                		$scope.documents = aData;
		                	});
		                },

		                loadDocuments: function(){
		                	// Empty the search text
		                	$scope.searchText = '';

		                	DocumentsService.getDocuments().then(function(aData){
		                		$scope.documents = aData;
		                	});
		                },

		                documentOwner: {
		                	hasOwner: $route.current.params.convocationId != null || $route.current.params.dayOrderId != null,
		                	type: $route.current.params.convocationId ? 'CONVOCATION' : 'DAYORDER',
		                			id: $route.current.params.convocationId | $route.current.params.dayOrderId
		                },

		                canEdit: function(){
		                	return $scope.currentUser.systemRole == 'ADMIN' || $scope.currentUser.systemRole == 'SEGRETARY';
		                },

		                linkDocument: function(nId) {
		                	//console.log('nId: ', nId, $scope.documentOwner);

		                	if($scope.documentOwner) {
		                		if($scope.documentOwner.type == 'DAYORDER') {
		                			DocumentsService.linkDayOrderDocument($scope.documentOwner.id, nId, '').success(function(oResp){
		                				$window.history.back();
		                			});
		                		} else if($scope.documentOwner.type == 'CONVOCATION') {
		                			DocumentsService.linkConvocationDocument($scope.documentOwner.id, nId).success(function(oResp){
		                				$window.history.back();
		                			});
		                		}
		                	}
		                },

		                deleteDocument: function(oDocument) {
		                	DocumentsService.deleteDocument(oDocument);
		                },

		                nodeSelectEvent: function(oData) {
		                	console.log('Select: %o', oData);
		                },

		                getDocumentTypeName: function(oDoc) {
		                	if(oDoc.contentType == 'application/pdf'){
		                		return 'PDF';
		                	} else if(oDoc.contentType == 'image/png' || oDoc.contentType == 'image/jpg' || oDoc.contentType == 'image/jpeg') {
		                		return 'Immagine';
		                	}
		                	return oDoc.contentType;
		                },

		                getDocumentType: function() {
		                	return $scope.documentType.value;
		                },

		                initFileUpload: function($scope) {
		                	jQuery('#fileupload').fileupload({
		                		formData: {
		                			type : 1,
		                			permission : $scope.getDocumentType()
		                		},
		                		add: function (e, data) {
		                			var jqXHR = data.submit()
		                			//.success(function (result, textStatus, jqXHR) {console.log(result);})
		                			.error(function (jqXHR, textStatus, errorThrown) {console.log(jqXHR);})
		                			.complete(function (oResp, textStatus, jqXHR) {
		                				$scope.documents.unshift(oResp);
		                				$scope.$digest();
		                			});
		                		}
		                	});
		                }
	});

	$scope.documentType = $scope.documentTypes[0];
	$scope.initFileUpload($scope);
});