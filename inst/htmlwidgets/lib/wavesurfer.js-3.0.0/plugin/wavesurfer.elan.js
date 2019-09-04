/*!
 * wavesurfer.js elan plugin 3.0.0 (2019-09-04)
 * https://github.com/katspaugh/wavesurfer.js
 * @license BSD-3-Clause
 */
(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory();
	else if(typeof define === 'function' && define.amd)
		define("elan", [], factory);
	else if(typeof exports === 'object')
		exports["elan"] = factory();
	else
		root["WaveSurfer"] = root["WaveSurfer"] || {}, root["WaveSurfer"]["elan"] = factory();
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
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/plugin/elan.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/plugin/elan.js":
/*!****************************!*\
  !*** ./src/plugin/elan.js ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

/**
 * @typedef {Object} ElanPluginParams
 * @property {string|HTMLElement} container CSS selector or HTML element where
 * the ELAN information should be rendered.
 * @property {string} url The location of ELAN XML data
 * @property {?boolean} deferInit Set to true to manually call
 * @property {?Object} tiers If set only shows the data tiers with the `TIER_ID`
 * in this map.
 */

/**
 * Downloads and renders ELAN audio transcription documents alongside the
 * waveform.
 *
 * @implements {PluginClass}
 * @extends {Observer}
 * @example
 * // es6
 * import ElanPlugin from 'wavesurfer.elan.js';
 *
 * // commonjs
 * var ElanPlugin = require('wavesurfer.elan.js');
 *
 * // if you are using <script> tags
 * var ElanPlugin = window.WaveSurfer.elan;
 *
 * // ... initialising wavesurfer with the plugin
 * var wavesurfer = WaveSurfer.create({
 *   // wavesurfer options ...
 *   plugins: [
 *     ElanPlugin.create({
 *       // plugin options ...
 *     })
 *   ]
 * });
 */
var ElanPlugin =
/*#__PURE__*/
function () {
  _createClass(ElanPlugin, null, [{
    key: "create",

    /**
     * Elan plugin definition factory
     *
     * This function must be used to create a plugin definition which can be
     * used by wavesurfer to correctly instantiate the plugin.
     *
     * @param  {ElanPluginParams} params parameters use to initialise the plugin
     * @return {PluginDefinition} an object representing the plugin
     */
    value: function create(params) {
      return {
        name: 'elan',
        deferInit: params && params.deferInit ? params.deferInit : false,
        params: params,
        instance: ElanPlugin
      };
    }
  }]);

  function ElanPlugin(params, ws) {
    _classCallCheck(this, ElanPlugin);

    this.Types = {
      ALIGNABLE_ANNOTATION: 'ALIGNABLE_ANNOTATION',
      REF_ANNOTATION: 'REF_ANNOTATION'
    };
    this.data = null;
    this.params = params;
    this.container = 'string' == typeof params.container ? document.querySelector(params.container) : params.container;

    if (!this.container) {
      throw Error('No container for ELAN');
    }
  }

  _createClass(ElanPlugin, [{
    key: "init",
    value: function init() {
      this.bindClick();

      if (this.params.url) {
        this.load(this.params.url);
      }
    }
  }, {
    key: "destroy",
    value: function destroy() {
      this.container.removeEventListener('click', this._onClick);
      this.container.removeChild(this.table);
    }
  }, {
    key: "load",
    value: function load(url) {
      var _this = this;

      this.loadXML(url, function (xml) {
        _this.data = _this.parseElan(xml);

        _this.render();

        _this.fireEvent('ready', _this.data);
      });
    }
  }, {
    key: "loadXML",
    value: function loadXML(url, callback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', url, true);
      xhr.responseType = 'document';
      xhr.send();
      xhr.addEventListener('load', function (e) {
        callback && callback(e.target.responseXML);
      });
    }
  }, {
    key: "parseElan",
    value: function parseElan(xml) {
      var _this2 = this;

      var _forEach = Array.prototype.forEach;
      var _map = Array.prototype.map;
      var data = {
        media: {},
        timeOrder: {},
        tiers: [],
        annotations: {},
        alignableAnnotations: []
      };
      var header = xml.querySelector('HEADER');
      var inMilliseconds = header.getAttribute('TIME_UNITS') == 'milliseconds';
      var media = header.querySelector('MEDIA_DESCRIPTOR');
      data.media.url = media.getAttribute('MEDIA_URL');
      data.media.type = media.getAttribute('MIME_TYPE');
      var timeSlots = xml.querySelectorAll('TIME_ORDER TIME_SLOT');
      var timeOrder = {};

      _forEach.call(timeSlots, function (slot) {
        var value = parseFloat(slot.getAttribute('TIME_VALUE')); // If in milliseconds, convert to seconds with rounding

        if (inMilliseconds) {
          value = Math.round(value * 1e2) / 1e5;
        }

        timeOrder[slot.getAttribute('TIME_SLOT_ID')] = value;
      });

      data.tiers = _map.call(xml.querySelectorAll('TIER'), function (tier) {
        return {
          id: tier.getAttribute('TIER_ID'),
          linguisticTypeRef: tier.getAttribute('LINGUISTIC_TYPE_REF'),
          defaultLocale: tier.getAttribute('DEFAULT_LOCALE'),
          annotations: _map.call(tier.querySelectorAll('REF_ANNOTATION, ALIGNABLE_ANNOTATION'), function (node) {
            var annot = {
              type: node.nodeName,
              id: node.getAttribute('ANNOTATION_ID'),
              ref: node.getAttribute('ANNOTATION_REF'),
              value: node.querySelector('ANNOTATION_VALUE').textContent.trim()
            };

            if (_this2.Types.ALIGNABLE_ANNOTATION == annot.type) {
              // Add start & end to alignable annotation
              annot.start = timeOrder[node.getAttribute('TIME_SLOT_REF1')];
              annot.end = timeOrder[node.getAttribute('TIME_SLOT_REF2')]; // Add to the list of alignable annotations

              data.alignableAnnotations.push(annot);
            } // Additionally, put into the flat map of all annotations


            data.annotations[annot.id] = annot;
            return annot;
          })
        };
      }); // Create JavaScript references between annotations

      data.tiers.forEach(function (tier) {
        tier.annotations.forEach(function (annot) {
          if (null != annot.ref) {
            annot.reference = data.annotations[annot.ref];
          }
        });
      }); // Sort alignable annotations by start & end

      data.alignableAnnotations.sort(function (a, b) {
        var d = a.start - b.start;

        if (d == 0) {
          d = b.end - a.end;
        }

        return d;
      });
      data.length = data.alignableAnnotations.length;
      return data;
    }
  }, {
    key: "render",
    value: function render() {
      var _this3 = this;

      // apply tiers filter
      var tiers = this.data.tiers;

      if (this.params.tiers) {
        tiers = tiers.filter(function (tier) {
          return tier.id in _this3.params.tiers;
        });
      } // denormalize references to alignable annotations


      var backRefs = {};
      var indeces = {};
      tiers.forEach(function (tier, index) {
        tier.annotations.forEach(function (annot) {
          if (annot.reference && annot.reference.type == _this3.Types.ALIGNABLE_ANNOTATION) {
            if (!(annot.reference.id in backRefs)) {
              backRefs[annot.ref] = {};
            }

            backRefs[annot.ref][index] = annot;
            indeces[index] = true;
          }
        });
      });
      indeces = Object.keys(indeces).sort();
      this.renderedAlignable = this.data.alignableAnnotations.filter(function (alignable) {
        return backRefs[alignable.id];
      }); // table

      var table = this.table = document.createElement('table');
      table.className = 'wavesurfer-annotations'; // head

      var thead = document.createElement('thead');
      var headRow = document.createElement('tr');
      thead.appendChild(headRow);
      table.appendChild(thead);
      var th = document.createElement('th');
      th.textContent = 'Time';
      th.className = 'wavesurfer-time';
      headRow.appendChild(th);
      indeces.forEach(function (index) {
        var tier = tiers[index];
        var th = document.createElement('th');
        th.className = 'wavesurfer-tier-' + tier.id;
        th.textContent = tier.id;
        th.style.width = _this3.params.tiers[tier.id];
        headRow.appendChild(th);
      }); // body

      var tbody = document.createElement('tbody');
      table.appendChild(tbody);
      this.renderedAlignable.forEach(function (alignable) {
        var row = document.createElement('tr');
        row.id = 'wavesurfer-alignable-' + alignable.id;
        tbody.appendChild(row);
        var td = document.createElement('td');
        td.className = 'wavesurfer-time';
        td.textContent = alignable.start.toFixed(1) + '–' + alignable.end.toFixed(1);
        row.appendChild(td);
        var backRef = backRefs[alignable.id];
        indeces.forEach(function (index) {
          var tier = tiers[index];
          var td = document.createElement('td');
          var annotation = backRef[index];

          if (annotation) {
            td.id = 'wavesurfer-annotation-' + annotation.id;
            td.dataset.ref = alignable.id;
            td.dataset.start = alignable.start;
            td.dataset.end = alignable.end;
            td.textContent = annotation.value;
          }

          td.className = 'wavesurfer-tier-' + tier.id;
          row.appendChild(td);
        });
      });
      this.container.innerHTML = '';
      this.container.appendChild(table);
    }
  }, {
    key: "bindClick",
    value: function bindClick() {
      var _this4 = this;

      this._onClick = function (e) {
        var ref = e.target.dataset.ref;

        if (null != ref) {
          var annot = _this4.data.annotations[ref];

          if (annot) {
            _this4.fireEvent('select', annot.start, annot.end);
          }
        }
      };

      this.container.addEventListener('click', this._onClick);
    }
  }, {
    key: "getRenderedAnnotation",
    value: function getRenderedAnnotation(time) {
      var result;
      this.renderedAlignable.some(function (annotation) {
        if (annotation.start <= time && annotation.end >= time) {
          result = annotation;
          return true;
        }

        return false;
      });
      return result;
    }
  }, {
    key: "getAnnotationNode",
    value: function getAnnotationNode(annotation) {
      return document.getElementById('wavesurfer-alignable-' + annotation.id);
    }
  }]);

  return ElanPlugin;
}();

exports.default = ElanPlugin;
module.exports = exports.default;

/***/ })

/******/ });
});
//# sourceMappingURL=wavesurfer.elan.js.map