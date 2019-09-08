

HTMLWidgets.widget({

  name: "wavesurfer",

  type: "output",

  factory: function(el, width, height) {


    var initialized = false;
    var elementId = el.id;
    var container =  document.getElementById(elementId);


    //plugins pre-defined options
    var pluginOptions = {
        microphone: {
            deferInit: true
        },
        regions: {
            dragSelection: true,
            deferInit: true
        }
    };
    var wsf = WaveSurfer.create({
      container: container,
      wavaColor: "#ff0933",
      //visualization: "spectrogram",
      plugins: [
          WaveSurfer.regions.create(pluginOptions.regions),
          WaveSurfer.microphone.create(pluginOptions.microphone)
      ]
    });

    return {
      renderValue: function(x) {
        // alias this
        var that = this;

        // initialize with audio
        if(!x.audio) {
          wsf.load(peaks = [0]);
        } else {
          wsf.load(x.audio);
        }

        //get regions data to pass to R
        function get_regions_data(regionsList, e) {
            var current_regions = regionsList;
            if(Object.keys(current_regions).length) {
              var regions_data = JSON.stringify(
              Object.keys(current_regions).map(function (id) {
                  var region = current_regions[id];
                  return get_region_data(region);
              })
            );
            return(regions_data);
          }
        }

        function get_region_data(region) {
          return {
            sound_id: region.attributes.sound_id ? region.attributes.sound_id.toString() : x.audio,
            segment_id: region.id,
            start: region.start,
            end: region.end,
            label: region.attributes.label ? region.attributes.label.toString() : ""
          };
        }

        // insert annotations in batch
        function insertAnnotations(annotations) {
          annotations = HTMLWidgets.dataframeToD3(annotations);
          if (typeof annotations !== 'undefined') {
            annotations.forEach(function(obj) {
              wsf.addRegion(obj);
            });
          }
        }

        // play_pause with spacebar
        function onKeyDown(event) {

          switch (event.keyCode) {
              case 32: //spaceBar
                  {
                    wsf.playPause();
                    event.preventDefault();
                  }
                  break;
          }
          return false;
        }

        if (!initialized) {
          // play_pause with spacebar
          window.addEventListener("keydown", onKeyDown, false);
          initialized = true;

          // attach the wsf object and the widget to the DOM
          container.wsf = wsf;
          container.widget = that;

          // set listeners to events and pass data back to Shiny
          if (HTMLWidgets.shinyMode) {

            wsf.on('finish', function () {
              Shiny.onInputChange(elementId + "_is_playing", wsf.isPlaying());
              Shiny.onInputChange(elementId + "_current_time", wsf.getCurrentTime());
            });

            wsf.on('interaction', function () {
              Shiny.onInputChange(elementId + "_current_time", wsf.getCurrentTime());
            });

            wsf.on('loading', function (loadingProgress) {
              Shiny.onInputChange(elementId + "_progress", loadingProgress);
            });

            wsf.on('mute', function (muteStatus) {
              Shiny.onInputChange(elementId + "_mute", muteStatus);
            });

            wsf.on('play', function () {
              Shiny.onInputChange(elementId + "_is_playing", wsf.isPlaying());
            });

            wsf.on('pause', function () {
              Shiny.onInputChange(elementId + "_is_playing", wsf.isPlaying());
              Shiny.onInputChange(elementId + "_current_time", wsf.getCurrentTime());
            });

            wsf.on('ready', function () {
              $('#'+elementId)[0].style.position = 'relative';
              Shiny.onInputChange(elementId + "_wave_color", wsf.getWaveColor());
              Shiny.onInputChange(elementId + "_progress_color", wsf.getProgressColor());
              Shiny.onInputChange(elementId + "_cursor_color", wsf.getCursorColor());
              Shiny.onInputChange(elementId + "_background_color", wsf.getBackgroundColor());
              Shiny.onInputChange(elementId + "_is_playing", wsf.isPlaying());
              Shiny.onInputChange(elementId + "_volume", wsf.getVolume());
              Shiny.onInputChange(elementId + "_mute", wsf.getMute());
              Shiny.onInputChange(elementId + "_duration", wsf.getDuration());
              Shiny.onInputChange(elementId + "_current_time", wsf.getCurrentTime());
              Shiny.onInputChange(elementId + "_playback_rate", wsf.getPlaybackRate());

              if(wsf.getActivePlugins().regions) {
                Shiny.onInputChange(elementId + "_regions:regionsDF", get_regions_data(wsf.regions.list));
              }

            });

            wsf.on('seek', function (progress) {
              Shiny.onInputChange(elementId + "_progress", progress);
            });

            wsf.on('volume', function (newVolume) {
              Shiny.onInputChange(elementId + "_volume", newVolume);
            });

            wsf.on('zoom', function (minPxPerSec) {
              Shiny.onInputChange(elementId + "_zoom", minPxPerSec);
            });


            //regions plugin events ----------------------------------------------
            wsf.on("region-created", function(region) {
              region.element.click();
            });

            wsf.on("region-updated", function(region, e) {
              Shiny.onInputChange(elementId + "_selected_region:regionsDF", JSON.stringify(get_region_data(region)));
              Shiny.onInputChange(elementId + "_regions:regionsDF", get_regions_data(wsf.regions.list));
            });

            wsf.on("region-update-end", function(region) {
              region.element.click();
            });

            wsf.on("region-removed", function(region) {
              Shiny.onInputChange(elementId + "_regions:regionsDF", get_regions_data(wsf.regions.list));
              Shiny.onInputChange(elementId + "_selected_region:regionsDF", "{}");
            });

            wsf.on("region-click", function(region) {
              //border highlights
              var regions_list = wsf.regions.list;
              Object.keys(regions_list).map(function(id) {
                regions_list[id].element.classList.remove('region-selected');
              });
              region.element.classList.add('region-selected');

              //region labeller input (selectize)
              var region_labeller_input = $('#'+elementId+'_region_labeller')[0].selectize;

              //update onchange event
              region_labeller_input.off("type");
              region_labeller_input.on("type", function(value) {
                region.attributes.label = value;
                region.update(0);
              });
              region_labeller_input.off("change");
              region_labeller_input.on("change", function(value) {
                region.attributes.label = value;
                region.update(0);
              });
              region_labeller_input.off("blur");
              region_labeller_input.on("blur", function() {
                region.attributes.label = region_labeller_input.getValue();
                region.update(0);
              });

              //focus on region labeller input
              region_labeller_input.focus();

              //retrieve current region label to the region labeller input
              if(region.attributes.label) {
                lbl = region.attributes.label.toString();
                region_labeller_input.addOption({value: lbl, label: lbl});
                region_labeller_input.addItem(lbl, 1);
                region_labeller_input.setValue(lbl);
              } else {
                region_labeller_input.setValue(null);
              }


            });
          }
          // listeners with no shiny dependency
          wsf.on("region-dblclick", function(region, e) {
            region.remove();
          });

        }

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
        wsf.audioUrl = x.audio;
        wsf.initialAnnotations = x.annotations;
        wsf.insertAnnotations = insertAnnotations;
        wsf.elementId = elementId;

        //add regions passed by the user
        wsf.clearRegions();
        insertAnnotations(x.annotations);

        //enable region labeller?
        if(x.settings.region_labeller) {
          region_labeller_display = 'block';
        } else {
          region_labeller_display = 'none';
        }
        $('#'+elementId+'_region_labeller').closest('.form-group')[0].style.display = region_labeller_display;

        //apply api queue
        var numApiCalls = x.api.length;
        for (var i = 0; i < numApiCalls; i++) {
          var call = x.api[i];
          var method = call.method;
          try {
            this[method](call);
          } catch(err) {}
        }

      },


      wsf: wsf,

      initInactivePlugin: function (plugin) {
        if(!wsf.getActivePlugins()[plugin]) {
          wsf.initPlugin(plugin);
        }
      },

      resize : function(width, height) {
        // no need
      },

      ws_regions: function() {
        if (!wsf.regions.wavesurfer.isReady) {
          setTimeout(() => this.ws_regions(), 1000);
          return;
        }
        this.initInactivePlugin('regions');
      },

      ws_add_regions: function(message) {
        wsf.insertAnnotations(message.annotations);
      },

      ws_clear_regions: function() {
        wsf.clearRegions();
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

      ws_set_height: function(message) {
        wsf.setPlaybackRate(message.height);
      },

      ws_zoom: function(message) {
        wsf.zoom(message.px_per_sec);
      },

      ws_load: function(message) {
        wsf.load(message.url, message.peaks, message.preload, message.duration);
      },

      ws_seek_to: function(message) {
        wsf.seekTo(message.progress);
      },

      ws_seek_and_center: function(message) {
        wsf.seekAndCenter(message.progress);
      },

      ws_minimap: function(message) {
        if(!wsf.getActivePlugins().minimap) {
          wsf.addPlugin(WaveSurfer.minimap.create(message)).initPlugin('minimap');
        } else {
          wsf.destroyPlugin('minimap');
        }
      },

      ws_microphone: function() {
        this.initInactivePlugin('microphone');
      },

      ws_spectrogram: function(message) {
        if(!wsf.getActivePlugins().spectrogram) {
          message.container = '#' + wsf.elementId + '-spectrogram';
          wsf.addPlugin(WaveSurfer.spectrogram.create(message)).initPlugin('spectrogram');
        } else {
          wsf.destroyPlugin('spectrogram');
        }
      },

      ws_cursor: function(message) {
        if(!wsf.getActivePlugins().cursor) {
          wsf.addPlugin(WaveSurfer.cursor.create(message)).initPlugin('cursor');
        } else {
          wsf.destroyPlugin('cursor');
        }
      },

      ws_timeline: function() {
        if(!wsf.getActivePlugins().timeline) {
          let timelineContainer = '#' + wsf.elementId + '-timeline';
          wsf.addPlugin(WaveSurfer.timeline.create({container: timelineContainer})).initPlugin('timeline');
        } else {
          wsf.destroyPlugin('timeline');
        }
      },

      ws_on: function(message) {
        if(message.replace) {
          wsf.un(message.event);
        }
        wsf.on(message.event, message.callback);
      },

      ws_un: function(message) {
        wsf.un(message.event);
      },

      ws_un_all: function(message) {
        wsf.unAll();
      },

      ws_microphone_stop: function(message) {
        if (wsf.microphone.active) {
          wsf.microphone.stop();
        }
      },

      ws_microphone_start: function(message) {
        if (wsf.microphone.active) {
          wsf.microphone.start();
        }
      },

      ws_region_labeller: function(message) {
        if(message.enable) {
          region_labeller_display = 'block';
        } else {
          region_labeller_display = 'none';
        }
        $('#'+elementId+'_region_labeller').closest('.form-group')[0].style.display = region_labeller_display;
      }
    };
  }
});


if (HTMLWidgets.shinyMode) {
  var fxns = ['ws_add_regions', 'ws_clear_regions', 'ws_play', 'ws_pause',
              'ws_play_pause', 'ws_destroy', 'ws_cancel_ajax',
              'ws_set_mute', 'ws_stop', 'ws_toggle_mute',
              'ws_toggle_interaction', 'ws_toggle_scroll',
              'ws_skip', 'ws_skip_backward', 'ws_skip_forward',
              'ws_set_wave_color', 'ws_set_progress_color', 'ws_set_volume',
              'ws_set_playback_rate', 'ws_set_background_color', 'ws_zoom',
              'ws_set_height', 'ws_load', 'ws_seek_to', 'ws_seek_and_center',
              'ws_minimap', 'ws_microphone', 'ws_regions',
              'ws_spectrogram', 'ws_cursor', 'ws_timeline',
              'ws_on', 'ws_un', 'ws_un_all', 'ws_microphone_stop', 'ws_microphone_start',
              'ws_region_labeller'];

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

