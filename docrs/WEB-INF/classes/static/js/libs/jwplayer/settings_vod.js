$(document).ready(function() {

	// Indirizzo del flusso HLS per IOS - valido anche per Flash se viene utilizzata una licenza
	var hlsStream = "http://live.streamincloud.it/vod/_definst_/smil:fiumicino/20130702.smil/playlist.m3u8";
	
	// Indirizzo del flusso RTMP per Flash
	var rtmpStream = "rtmp://live.streamincloud.it/vod/_definst_/smil:fiumicino/fiumicino20130702.smil";
	
	// Indirizzo del flusso RTSP per Android
	var rtspStream = "rtsp://live.streamincloud.it/vod/_definst_/mp4:fiumicino/fiumicino_live100.mp4"; 

	// Recupero la width della finestra per gestire la dimensione del player (commentare la proporzione non utilizzata)
	// 4:3
	//var playerHeight = ($('#VideoContainer').width()/4)*3;  
	// 16:9
	var playerHeight = ($('#VideoContainer').width()/16)*9;

	// Per Android redirect al flusso RTSP
	if(navigator.userAgent.toLowerCase().indexOf("android") > -1) {
		// RTSP
		window.location = rtspStream;
	} else {
		// Altrimenti verifico la versione di Flash installata (deve essere > 10)...
		var version = getFlashVersion().split(',').shift();
		//alert("|| "+version+", "+navigator.userAgent.toLowerCase().indexOf("iphone")+", "+navigator.userAgent.toLowerCase().indexOf("ipad"));
		if(version && version < 10 && navigator.userAgent.toLowerCase().indexOf("iphone") == -1 && navigator.userAgent.toLowerCase().indexOf("ipad") == -1){
			// Flash player versione minore di 10 o no Flash
			$("#video_wrapper").html("<div style=\"text-align: center;\"><p>Per visualizzare la seduta e' necessario<br>aggiornare il Flash Player plugin<br>alla versione 10 o superiore</p><a href=\"http://get.adobe.com/it/flashplayer/\" target=\"_blank\"><img src=\"http://www.radio24.ilsole24ore.com/images2013/160x41_get_flashplayer.gif\" ></a></div><br>");
		}else{
			// Altrimenti, se iOS o  Flash versione >= 10, istanzio jwplayer con HLS/RMTP ...
			jwplayer("video").setup({
				autostart: true,
				// Setto flash come prioritario
				'primary': 'flash',
				'width': '100%',
				'aspectratio':'16:9',
				// height:360
				events:{
					onPlay: function() {
						//alert(jwplayer().getCurrentQuality()+", "+jwplayer().getQualityLevels()[jwplayer().getCurrentQuality()].label);
						if(jwplayer().getPosition() == 0){
							jwplayer().setCurrentQuality(jwplayer().getQualityLevels().length-1);
							jwplayer("video").seek(975);
							//jwplayer().setCurrentQuality(0);
						}
					}
				},
				'type': 'hls',
				'file':hlsStream
				/*'playlist': [{
					// Percorso della cover
					//image: './files/cover.png',
					sources: [
					// HLS
					{
						type: 'hls',
						file: hlsStream
					}/*, 
					// RTMP
					{
						type:"rtmp",
						file: rtmpStream
					}
					]
				}]*/
			});
		}
	}
});