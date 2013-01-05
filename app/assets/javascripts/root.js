downloadSongs = function(callback) {
  return $.get('/songs.json', function(data) {
    window.songs.push.apply(window.songs, data);
    callback();
  });
};

performQueries = function(keywords) {
  var keyword, the_url;

  if(keywords.length == 0)
    return;

  keyword = keywords[0];
  the_url = "http://gdata.youtube.com/feeds/api/videos?q=" + encodeURIComponent(keyword) + "&format=5&max-results=1&v=2&alt=jsonc";
  $.ajax({
    type: "GET",
    url: the_url,
    dataType: "jsonp",
    success: function(responseData, textStatus, XMLHttpRequest) {
      var videos;
      if (responseData.data.items) {
        videos = responseData.data.items;
        window.youtubeQueue.push(videos[0]);
        if(typeof(window.YTPlayer) === "undefined") {
          playVideo();
        }
        renderQueue();
      }
      performQueries(keywords.slice(1));
    }
  });
};

renderQueue = function() {
  $('#queue').html(_.map(window.youtubeQueue, function(ytItem) {
    return '<img src="'+ytItem.thumbnail.hqDefault+'" />' +
      '<h2>'+ytItem.title+'</h2>';
  }).join(''));
};

playVideo = function() {

  var video = window.youtubeQueue[0];
  window.youtubeQueue = window.youtubeQueue.slice(1);

  
  if(typeof(window.YTPlayer) === "undefined") {
    window.YTPlayer = new YT.Player('player', {
        height: '390',
        width: '640',
        videoId: video.id,
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      });
  } else {
    window.YTPlayer.loadVideoById(video.id);
  }

  renderQueue();
}

// autoplay video
function onPlayerReady(event) {
    event.target.playVideo();
}

// when video ends
function onPlayerStateChange(event) {        
    if(event.data === 0) {          
        playVideo();
    }
}


$(function() {
  window.songs = [];
  window.youtubeQueue = [];
  
  downloadSongs(function() {
    var queries = _.map(window.songs, function(song) {
      return song.query;
    });
    performQueries(queries);
  });
});
