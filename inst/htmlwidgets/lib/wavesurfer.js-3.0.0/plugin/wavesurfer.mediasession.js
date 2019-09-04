/*!
 * wavesurfer.js mediasession plugin 3.0.0 (2019-09-04)
 * https://github.com/katspaugh/wavesurfer.js
 * @license BSD-3-Clause
 */
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory();
	else if(typeof define === 'function' && define.amd)
		define("mediasession", [], factory);
	else if(typeof exports === 'object')
		exports["mediasession"] = factory();
	else
		root["WaveSurfer"] = root["WaveSurfer"] || {}, root["WaveSurfer"]["mediasession"] = factory();
})(window, function() {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "localhost:8080/dist/plugin/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/plugin/mediasession.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/plugin/mediasession.js":
/*!************************************!*\
  !*** ./src/plugin/mediasession.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

/*global MediaMetadata*/

/**
 * @typedef {Object} MediaSessionPluginParams
 * @property {MediaMetadata} metadata A MediaMetadata object: a representation
 * of the metadata associated with a MediaSession that can be used by user agents
 * to provide a customized user interface.
 * @property {?boolean} deferInit Set to true to manually call
 * `initPlugin('mediasession')`
 */

/**
 * Visualize MediaSession information for a wavesurfer instance.
 *
 * @implements {PluginClass}
 * @extends {Observer}
 * @example
 * // es6
 * import MediaSessionPlugin from 'wavesurfer.mediasession.js';
 *
 * // commonjs
 * var MediaSessionPlugin = require('wavesurfer.mediasession.js');
 *
 * // if you are using <script> tags
 * var MediaSessionPlugin = window.WaveSurfer.mediasession;
 *
 * // ... initialising wavesurfer with the plugin
 * var wavesurfer = WaveSurfer.create({
 *   // wavesurfer options ...
 *   plugins: [
 *     MediaSessionPlugin.create({
 *       // plugin options ...
 *     })
 *   ]
 * });
 */
var MediaSessionPlugin =
/*#__PURE__*/
function () {
  _createClass(MediaSessionPlugin, null, [{
    key: "create",

    /**
     * MediaSession plugin definition factory
     *
     * This function must be used to create a plugin definition which can be
     * used by wavesurfer to correctly instantiate the plugin.
     *
     * @param  {MediaSessionPluginParams} params parameters use to initialise the plugin
     * @return {PluginDefinition} an object representing the plugin
     */
    value: function create(params) {
      return {
        name: 'mediasession',
        deferInit: params && params.deferInit ? params.deferInit : false,
        params: params,
        instance: MediaSessionPlugin
      };
    }
  }]);

  function MediaSessionPlugin(params, ws) {
    var _this = this;

    _classCallCheck(this, MediaSessionPlugin);

    this.params = params;
    this.wavesurfer = ws;

    if ('mediaSession' in navigator) {
      // update metadata
      this.metadata = this.params.metadata;
      this.update(); // update metadata when playback starts

      this.wavesurfer.on('play', function () {
        _this.update();
      }); // set playback action handlers

      navigator.mediaSession.setActionHandler('play', function () {
        _this.wavesurfer.play();
      });
      navigator.mediaSession.setActionHandler('pause', function () {
        _this.wavesurfer.playPause();
      });
      navigator.mediaSession.setActionHandler('seekbackward', function () {
        _this.wavesurfer.skipBackward();
      });
      navigator.mediaSession.setActionHandler('seekforward', function () {
        _this.wavesurfer.skipForward();
      });
    }
  }

  _createClass(MediaSessionPlugin, [{
    key: "init",
    value: function init() {}
  }, {
    key: "destroy",
    value: function destroy() {}
  }, {
    key: "update",
    value: function update() {
      if ((typeof MediaMetadata === "undefined" ? "undefined" : _typeof(MediaMetadata)) === (typeof Function === "undefined" ? "undefined" : _typeof(Function))) {
        // set metadata
        navigator.mediaSession.metadata = new MediaMetadata(this.metadata);
      }
    }
  }]);

  return MediaSessionPlugin;
}();

exports.default = MediaSessionPlugin;
module.exports = exports.default;

/***/ })

/******/ });
});
//# sourceMappingURL=wavesurfer.mediasession.js.map