

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
      renderValue: function(setup) {
        container.widget = this;

        wsf.params.audioContext = setup.settings.audioContext;
        wsf.params.audioRate = setup.settings.audioRate;
        wsf.params.audioScriptProcessor = setup.settings.audioScriptProcessor;
        wsf.params.autoCenter = setup.settings.autoCenter;
        wsf.params.backend = setup.settings.backend;
        wsf.params.backgroundColor = setup.settings.backgroundColor;
        wsf.params.barHeight = setup.settings.barHeight;
        wsf.params.barGap = setup.settings.barGap;
        wsf.params.barWidth = setup.settings.barWidth;
        wsf.params.closeAudioContext = setup.settings.closeAudioContext;
        wsf.params.cursorColor = setup.settings.cursorColor;
        wsf.params.cursorWidth = setup.settings.cursorWidth;
        wsf.params.duration = setup.settings.duration;
        wsf.params.fillParent = setup.settings.fillParent;
        wsf.params.forceDecode = setup.settings.forceDecode;
        wsf.params.hideScrollbar = setup.settings.hideScrollbar;
        wsf.params.interact = setup.settings.interact;
        wsf.params.loopSelection = setup.settings.loopSelection;
        wsf.params.maxCanvasWidth = setup.settings.maxCanvasWidth;
        wsf.params.mediaControls = setup.settings.mediaControls;
        wsf.params.mediaType = setup.settings.mediaType;
        wsf.params.minPxPerSec = setup.settings.minPxPerSec;
        wsf.params.normalize = setup.settings.normalize;
        wsf.params.partialRender = setup.settings.partialRender;
        wsf.params.progressColor = setup.settings.progressColor;
        wsf.params.removeMediaElementOnDestroy = setup.settings.removeMediaElementOnDestroy;
        wsf.params.responsive = setup.settings.responsive;
        wsf.params.rtl = setup.settings.rtl;
        wsf.params.scrollParent = setup.settings.scrollParent;
        wsf.params.skipLength = setup.settings.skipLength;
        wsf.params.splitChannels = setup.settings.splitChannels;
        wsf.params.waveColor = setup.settings.waveColor;
        wsf.params.xhr = setup.settings.xhr;

        wsf.load(setup.audio);

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
        var annotations = HTMLWidgets.dataframeToD3(setup.annotations);
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


      },

      w: wsf,

      ws_addRegions: function(message) {
        var annotations = HTMLWidgets.dataframeToD3(message.annotations);
        annotations.forEach(function(obj) {wsf.addRegion(obj)});
      },

      ws_play: function(message) {
        wsf.play(message.start, message.end);
      },

      ws_pause: function() {
        wsf.pause();
      },

      ws_playPause: function() {
        wsf.playPause();
      },

      ws_destroy: function() {
        wsf.destroy();
      }
    };
  }
});


if (HTMLWidgets.shinyMode) {
  var fxns = ['ws_addRegions', 'ws_play', 'ws_pause', 'ws_playPause', 'ws_destroy'];

  var addShinyHandler = function(fxn) {
    return function() {
      Shiny.addCustomMessageHandler(
        "wavesurfer:" + fxn, function(message) {
          var el = document.getElementById(message.wavesurferId);
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

