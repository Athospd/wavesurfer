

HTMLWidgets.widget({

  name: "wavesurfer",

  type: "output",

  factory: function(el, width, height) {

    //var initialized = false;
    var elementId = el.id;
    var container =  document.getElementById(elementId);
    var wsf = WaveSurfer.create({
      container: container,
      plugins: [
          WaveSurfer.regions.create({
              dragSelection: {
                  slop: 5
              }
          })
      ]

    });

    return {
      renderValue: function(x) {
        container.widget = this;

        wsf.params.audioContext = x.settings.audioContext;
        wsf.params.audioRate = x.settings.audioRate;
        wsf.params.audioScriptProcessor = x.settings.audioScriptProcessor;
        wsf.params.autoCenter = x.settings.autoCenter;
        wsf.params.backend = x.settings.backend;
        wsf.params.backgroundColor = x.settings.backgroundColor;
        wsf.params.barHeight = x.settings.barHeight;
        wsf.params.barGap = x.settings.barGap;
        wsf.params.barWidth = x.settings.barWidth;
        wsf.params.closeAudioContext = x.settings.closeAudioContext;
        wsf.params.cursorColor = x.settings.cursorColor;
        wsf.params.cursorWidth = x.settings.cursorWidth;
        wsf.params.duration = x.settings.duration;
        wsf.params.fillParent = x.settings.fillParent;
        wsf.params.forceDecode = x.settings.forceDecode;
        wsf.params.hideScrollbar = x.settings.hideScrollbar;
        wsf.params.interact = x.settings.interact;
        wsf.params.loopSelection = x.settings.loopSelection;
        wsf.params.maxCanvasWidth = x.settings.maxCanvasWidth;
        wsf.params.mediaControls = x.settings.mediaControls;
        wsf.params.mediaType = x.settings.mediaType;
        wsf.params.minPxPerSec = x.settings.minPxPerSec;
        wsf.params.normalize = x.settings.normalize;
        wsf.params.partialRender = x.settings.partialRender;
        wsf.params.progressColor = x.settings.progressColor;
        wsf.params.removeMediaElementOnDestroy = x.settings.removeMediaElementOnDestroy;
        wsf.params.responsive = x.settings.responsive;
        wsf.params.rtl = x.settings.rtl;
        wsf.params.scrollParent = x.settings.scrollParent;
        wsf.params.skipLength = x.settings.skipLength;
        wsf.params.splitChannels = x.settings.splitChannels;
        wsf.params.waveColor = x.settings.waveColor;
        wsf.params.xhr = x.settings.xhr;

        wsf.load(x.audio);

        function returnRegionsToInput(r, e) {
            var current_regions = wsf.regions.list;
            var regions_data = JSON.stringify(
              Object.keys(current_regions).map(function (id) {
                  var region = current_regions[id];
                  return {
                    sound_id: region.sound_id,
                    segmentation_id: id,
                    start: region.start,
                    end: region.end
                  };
              })
            );
            Shiny.onInputChange(elementId + "_regions:regionsDF", regions_data);
        }
        var annotations = HTMLWidgets.dataframeToD3(x.annotations);
        wsf.clearRegions();
        if (typeof annotations !== 'undefined') {
          annotations.forEach(function(obj) {wsf.addRegion(obj)});
        }

        // listeners
        wsf.on("region-dblclick", function(region, e) {
          region.remove();
        });

        if (HTMLWidgets.shinyMode) {
          wsf.on("ready", function() {
            returnRegionsToInput();
          });

          wsf.on("region-created", function() {
            returnRegionsToInput();
          });

          wsf.on("region-updated", function() {
            returnRegionsToInput();
          });

          wsf.on("region-update-end", function() {
            returnRegionsToInput();
          });

          wsf.on("region-removed", function() {
            returnRegionsToInput();
          });
        }

        var numApiCalls = x.api.length;
        for (var i = 0; i < numApiCalls; i++) {
          var call = x.api[i];
          var method = call.method;
          try {
            this[method](call);
          } catch(err) {}
        }

      },

      w: wsf,

      ws_add_regions: function(message) {
        var annotations = HTMLWidgets.dataframeToD3(message.annotations);
        annotations.forEach(function(obj) {wsf.addRegion(obj)});
      },

      ws_play: function(message) {
        wsf.play(message.start, message.end);
      },

      ws_pause: function() {
        wsf.pause();
      },

      ws_play_pause: function() {
        wsf.playPause();
      },

      ws_destroy: function() {
        wsf.destroy();
      },

      ws_cancel_ajax: function() {
        wsf.cancelAjax();
      },

      ws_set_mute: function(message) {
        wsf.setMute(message.mute);
      },

      ws_stop: function() {
        wsf.stop();
      },

      ws_toggle_mute: function() {
        wsf.toggleMute();
      },

      ws_toggle_interaction: function() {
        wsf.toggleInteraction();
      },

      ws_toggle_scroll: function() {
        wsf.toggleScroll();
      },

      ws_skip: function(message) {
        wsf.skip(message.offset);
      },

      ws_skip_backward: function(message) {
        wsf.skipBackward(message.seconds);
      },

      ws_skip_forward: function(message) {
        wsf.skipForward(message.seconds);
      },

      ws_set_wave_color: function(message) {
        wsf.setWaveColor(message.color);
      },

      ws_set_progress_color: function(message) {
        wsf.setProgressColor(message.color);
      },

      ws_set_cursor_color: function(message) {
        wsf.setCursorColor(message.color);
      },

      ws_set_background_color: function(message) {
        wsf.setBackgroundColor(message.color);
      },

      ws_set_volume: function(message) {
        wsf.setVolume(message.new_volume);
      },

      ws_set_playback_rate: function(message) {
        wsf.setPlaybackRate(message.rate);
      },

      ws_zoom: function(message) {
        wsf.zoom(message.px_per_sec);
      }
    };
  }
});


if (HTMLWidgets.shinyMode) {
  var fxns = ['ws_add_regions', 'ws_play', 'ws_pause',
              'ws_play_pause', 'ws_destroy', 'ws_cancel_ajax',
              'ws_set_mute', 'ws_stop', 'ws_toggle_mute',
              'ws_toggle_interaction', 'ws_toggle_scroll',
              'ws_skip', 'ws_skip_backward', 'ws_skip_forward',
              'ws_set_wave_color', 'ws_set_progress_color', 'ws_set_volume',
              'ws_set_playback_rate', 'ws_set_background_color', 'ws_zoom'];

  var addShinyHandler = function(fxn) {
    return function() {
      Shiny.addCustomMessageHandler(
        "wavesurfer:" + fxn, function(message) {
          var el = document.getElementById(message.id);
          if (el) {
            el.widget[fxn](message);
          }
        }
      );
    };
  };

  for (var i = 0; i < fxns.length; i++) {
    addShinyHandler(fxns[i])();
  }
}

