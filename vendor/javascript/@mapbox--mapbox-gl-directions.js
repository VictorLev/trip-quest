import{bindActionCreators as t,createStore as e,applyMiddleware as i}from"redux";import n from"redux-thunk";import{decode as o}from"@mapbox/polyline";import r from"merge-options";import s from"suggestions";import a from"lodash.debounce";import{EventEmitter as c}from"events";import u from"lodash.template";import l from"lodash.isequal";import d from"turf-extent";function validCoords(t){return t[0]>=-180&&t[0]<=180&&t[1]>=-90&&t[1]<=90}function coordinateMatch(t,e){t=t.geometry.coordinates;e=e.geometry.coordinates;return t.join()===e.join()||t[0].toFixed(3)===e[0].toFixed(3)&&t[1].toFixed(3)===e[1].toFixed(3)}function wrap(t){var e=360;var i=((t- -180)%e+e)%e-180;return i===-180?180:i}function roundWithOriginalPrecision(t,e){let i=0;Math.floor(e)!==e&&(i=e.toString().split(".")[1].length);return t.toFixed(Math.min(i,5))}function createPoint(t,e){return{type:"Feature",geometry:{type:"Point",coordinates:t},properties:e||{}}}function getAllSteps(t,e){return t.legs.reduce(((t,i,n)=>{if(n>0){t[t.length-1].maneuver.type="waypoint";i.steps[0].maneuver.type=""}const o=t.concat(i.steps);return e?o.filter(e):o}),[])}const h={duration(t){var e=Math.floor(t/60),i=Math.floor(e/60);t%=60;e%=60;return i===0&&e===0?t+"s":i===0?e+"min":i+"h "+e+"min"},imperial(t){var e=t/1609.344;return e>=100?e.toFixed(0)+"mi":e>=10?e.toFixed(1)+"mi":e>=.1?e.toFixed(2)+"mi":(e*5280).toFixed(0)+"ft"},metric(t){return t>=1e5?(t/1e3).toFixed(0)+"km":t>=1e4?(t/1e3).toFixed(1)+"km":t>=100?(t/1e3).toFixed(2)+"km":t.toFixed(0)+"m"}};var p={format:h,coordinateMatch:coordinateMatch,createPoint:createPoint,validCoords:validCoords,wrap:wrap,roundWithOriginalPrecision:roundWithOriginalPrecision,getAllSteps:getAllSteps};const g="DESTINATION";const m="DESTINATION_CLEAR";const y="DESTINATION_QUERY";const f="DESTINATION_FROM_COORDINATES";const v="DIRECTIONS";const _="DIRECTIONS_REQUEST_START";const b="DIRECTIONS_PROFILE";const D="EVENTS";const E="ERROR";const O="HOVER_MARKER";const C="ORIGIN";const S="ORIGIN_CLEAR";const w="ORIGIN_QUERY";const x="ORIGIN_FROM_COORDINATES";const I="ROUTE_INDEX";const k="SET_OPTIONS";const q="WAYPOINTS";const getInitialState=()=>({api:"https://api.mapbox.com/directions/v5/",profile:"mapbox/driving-traffic",alternatives:false,congestion:false,unit:"imperial",flyTo:true,placeholderOrigin:"Choose a starting place",placeholderDestination:"Choose destination",zoom:16,language:"en",compile:null,proximity:false,styles:[],controls:{profileSwitcher:true,inputs:true,instructions:true},instructions:{showWaypointInstructions:true},geocoder:{},interactive:true,events:{},origin:{},destination:{},hoverMarker:{},waypoints:[],originQuery:null,destinationQuery:null,originQueryCoordinates:null,destinationQueryCoordinates:null,directions:[],fetchDirectionsRequest:null,routeIndex:0,routePadding:80});function data(t=getInitialState(),e){switch(e.type){case k:return r({},t,e.options);case b:return Object.assign({},t,{profile:e.profile});case C:return Object.assign({},t,{origin:e.origin,hoverMarker:{}});case g:return Object.assign({},t,{destination:e.destination,hoverMarker:{}});case O:return Object.assign({},t,{hoverMarker:e.hoverMarker});case q:return Object.assign({},t,{waypoints:e.waypoints});case w:return Object.assign({},t,{originQuery:e.query});case y:return Object.assign({},t,{destinationQuery:e.query});case x:return Object.assign({},t,{originQueryCoordinates:e.coordinates});case f:return Object.assign({},t,{destinationQueryCoordinates:e.coordinates});case S:return Object.assign({},t,{origin:{},originQuery:"",waypoints:[],directions:[]});case m:return Object.assign({},t,{destination:{},destinationQuery:"",waypoints:[],directions:[]});case _:return Object.assign({},t,{fetchDirectionsRequest:e.request});case v:return Object.assign({},t,{directions:e.directions,fetchDirectionsRequest:null});case I:return Object.assign({},t,{routeIndex:e.routeIndex});case E:return Object.assign({},t,{error:e.error});default:return t}}function originPoint(t){return e=>{const i=p.createPoint(t,{id:"origin","marker-symbol":"A"});e({type:C,origin:i});e(eventEmit("origin",{feature:i}))}}function destinationPoint(t){return e=>{const i=p.createPoint(t,{id:"destination","marker-symbol":"B"});e({type:g,destination:i});e(eventEmit("destination",{feature:i}))}}function directionsRequestStart(t){return e=>{e({type:_,request:t})}}function setDirections(t){return e=>{e({type:v,directions:t});e(eventEmit("route",{route:t}))}}function updateWaypoints(t){return{type:q,waypoints:t}}function setHoverMarker(t){return{type:O,hoverMarker:t}}function fetchDirections(){return(t,e)=>{const{api:i,accessToken:n,routeIndex:o,profile:r,alternatives:s,congestion:a,destination:c,language:u,exclude:l,fetchDirectionsRequest:d}=e();if(!(c&&c.geometry))return;d&&d.abort();const h=buildDirectionsQuery(e);var p=[];p.push("geometries=polyline");s&&p.push("alternatives=true");a&&p.push("annotations=congestion");p.push("steps=true");p.push("overview=full");u&&p.push("language="+u);l&&p.push("exclude="+l);n&&p.push("access_token="+n);const g=new XMLHttpRequest;g.open("GET",`${i}${r}/${h}.json?${p.join("&")}`,true);t(directionsRequestStart(g));g.onload=()=>{if(!(g.status>=200&&g.status<400)){t(setDirections([]));return t(setError(JSON.parse(g.responseText).message))}var e=JSON.parse(g.responseText);if(e.error){t(setDirections([]));return t(setError(e.error))}if(e.message==="No route found")return t(setError("No route found"));t(setError(null));e.routes[o]||t(setRouteIndex(0));t(setDirections(e.routes));t(originPoint(e.waypoints[0].location));t(destinationPoint(e.waypoints[e.waypoints.length-1].location))};g.onerror=()=>{t(setDirections([]));return g.responseText?t(setError(JSON.parse(g.responseText).message)):t(setError("Error"))};g.send()}}
/*
 * Build query used to fetch directions
 *
 * @param {Function} state
 */function buildDirectionsQuery(t){const{origin:e,destination:i,waypoints:n}=t();let o=[];o.push(e.geometry.coordinates.join(","));o.push(";");n.length&&n.forEach((t=>{o.push(t.geometry.coordinates.join(","));o.push(";")}));o.push(i.geometry.coordinates.join(","));return encodeURIComponent(o.join(""))}function normalizeWaypoint(t){const e={id:"waypoint"};return Object.assign(t,{properties:t.properties?Object.assign(t.properties,e):e})}function setError(t){return e=>{e({type:"ERROR",error:t});t&&e(eventEmit("error",{error:t}))}}function queryOrigin(t){return{type:w,query:t}}function queryDestination(t){return{type:y,query:t}}function queryOriginCoordinates(t){return{type:x,coordinates:t}}function queryDestinationCoordinates(t){return{type:f,coordinates:t}}function clearOrigin(){return t=>{t({type:S});t(eventEmit("clear",{type:"origin"}));t(setError(null))}}function clearDestination(){return(t,e)=>{const{fetchDirectionsRequest:i}=e();i&&i.abort();t({type:m});t(eventEmit("clear",{type:"destination"}));t(setError(null))}}function setOptions(t){return{type:k,options:t}}function hoverMarker(t){return e=>{const i=t?p.createPoint(t,{id:"hover"}):{};e(setHoverMarker(i))}}function setRouteIndex(t){return{type:I,routeIndex:t}}function createOrigin(t){return(e,i)=>{const{destination:n}=i();e(originPoint(t));n.geometry&&e(fetchDirections())}}function createDestination(t){return(e,i)=>{const{origin:n}=i();e(destinationPoint(t));n.geometry&&e(fetchDirections())}}function setProfile(t){return(e,i)=>{const{origin:n,destination:o}=i();e({type:b,profile:t});e(eventEmit("profile",{profile:t}));n.geometry&&o.geometry&&e(fetchDirections())}}function reverse(){return(t,e)=>{const i=e();i.destination.geometry&&t(originPoint(i.destination.geometry.coordinates));i.origin.geometry&&t(destinationPoint(i.origin.geometry.coordinates));i.origin.geometry&&i.destination.geometry&&t(fetchDirections());const n=document.getElementsByClassName("suggestions");for(var o=0;o<n.length;o++)n[o].style.visibility="hidden"}}
/*
 * Set origin from coordinates
 *
 * @param {Array<number>} coordinates [lng, lat] array.
 */function setOriginFromCoordinates(t){return e=>{p.validCoords(t)||(t=[p.wrap(t[0]),p.wrap(t[1])]);if(isNaN(t[0])&&isNaN(t[1]))return e(setError(new Error("Coordinates are not valid")));e(queryOriginCoordinates(t));e(createOrigin(t))}}
/*
 * Set destination from coordinates
 *
 * @param {Array<number>} coords [lng, lat] array.
 */function setDestinationFromCoordinates(t){return e=>{p.validCoords(t)||(t=[p.wrap(t[0]),p.wrap(t[1])]);if(isNaN(t[0])&&isNaN(t[1]))return e(setError(new Error("Coordinates are not valid")));e(createDestination(t));e(queryDestinationCoordinates(t))}}function addWaypoint(t,e){return(i,n)=>{let{destination:o,waypoints:r}=n();r.splice(t,0,normalizeWaypoint(e));i(updateWaypoints(r));o.geometry&&i(fetchDirections())}}function setWaypoint(t,e){return(i,n)=>{let{destination:o,waypoints:r}=n();r[t]=normalizeWaypoint(e);i(updateWaypoints(r));o.geometry&&i(fetchDirections())}}function removeWaypoint(t){return(e,i)=>{let{destination:n,waypoints:o}=i();o=o.filter((e=>!p.coordinateMatch(e,t)));e(updateWaypoints(o));n.geometry&&e(fetchDirections())}}function eventSubscribe(t,e){return(i,n)=>{const{events:o}=n();o[t]=o[t]||[];o[t].push(e);return{type:D,events:o}}}function eventEmit(t,e){return(i,n)=>{const{events:o}=n();if(!o[t])return{type:D,events:o};const r=o[t].slice();for(var s=0;s<r.length;s++)r[s].call(this,e)}}var T=Object.freeze(Object.defineProperty({__proto__:null,addWaypoint:addWaypoint,clearDestination:clearDestination,clearOrigin:clearOrigin,createDestination:createDestination,createOrigin:createOrigin,eventEmit:eventEmit,eventSubscribe:eventSubscribe,hoverMarker:hoverMarker,queryDestination:queryDestination,queryDestinationCoordinates:queryDestinationCoordinates,queryOrigin:queryOrigin,queryOriginCoordinates:queryOriginCoordinates,removeWaypoint:removeWaypoint,reverse:reverse,setDestinationFromCoordinates:setDestinationFromCoordinates,setOptions:setOptions,setOriginFromCoordinates:setOriginFromCoordinates,setProfile:setProfile,setRouteIndex:setRouteIndex,setWaypoint:setWaypoint},Symbol.toStringTag,{value:"Module"}));const R=[{id:"directions-route-line-alt",type:"line",source:"directions",layout:{"line-cap":"round","line-join":"round"},paint:{"line-color":"#bbb","line-width":4},filter:["all",["in","$type","LineString"],["in","route","alternate"]]},{id:"directions-route-line-casing",type:"line",source:"directions",layout:{"line-cap":"round","line-join":"round"},paint:{"line-color":"#2d5f99","line-width":12},filter:["all",["in","$type","LineString"],["in","route","selected"]]},{id:"directions-route-line",type:"line",source:"directions",layout:{"line-cap":"butt","line-join":"round"},paint:{"line-color":{property:"congestion",type:"categorical",default:"#4882c5",stops:[["unknown","#4882c5"],["low","#4882c5"],["moderate","#f09a46"],["heavy","#e34341"],["severe","#8b2342"]]},"line-width":7},filter:["all",["in","$type","LineString"],["in","route","selected"]]},{id:"directions-hover-point-casing",type:"circle",source:"directions",paint:{"circle-radius":8,"circle-color":"#fff"},filter:["all",["in","$type","Point"],["in","id","hover"]]},{id:"directions-hover-point",type:"circle",source:"directions",paint:{"circle-radius":6,"circle-color":"#3bb2d0"},filter:["all",["in","$type","Point"],["in","id","hover"]]},{id:"directions-waypoint-point-casing",type:"circle",source:"directions",paint:{"circle-radius":8,"circle-color":"#fff"},filter:["all",["in","$type","Point"],["in","id","waypoint"]]},{id:"directions-waypoint-point",type:"circle",source:"directions",paint:{"circle-radius":6,"circle-color":"#8a8bc9"},filter:["all",["in","$type","Point"],["in","id","waypoint"]]},{id:"directions-origin-point",type:"circle",source:"directions",paint:{"circle-radius":18,"circle-color":"#3bb2d0"},filter:["all",["in","$type","Point"],["in","marker-symbol","A"]]},{id:"directions-origin-label",type:"symbol",source:"directions",layout:{"text-field":"A","text-font":["Open Sans Bold","Arial Unicode MS Bold"],"text-size":12},paint:{"text-color":"#fff"},filter:["all",["in","$type","Point"],["in","marker-symbol","A"]]},{id:"directions-destination-point",type:"circle",source:"directions",paint:{"circle-radius":18,"circle-color":"#8a8bc9"},filter:["all",["in","$type","Point"],["in","marker-symbol","B"]]},{id:"directions-destination-label",type:"symbol",source:"directions",layout:{"text-field":"B","text-font":["Open Sans Bold","Arial Unicode MS Bold"],"text-size":12},paint:{"text-color":"#fff"},filter:["all",["in","$type","Point"],["in","marker-symbol","B"]]}];"use strict";class Geocoder{constructor(t){this._ev=new c;this.options=t;this.api=t&&t.api||"https://api.mapbox.com/geocoding/v5/mapbox.places/"}onAdd(t){this._map=t;this.request=new XMLHttpRequest;var e=document.createElement("div");e.className="mapboxgl-ctrl-geocoder";var i=document.createElement("span");i.className="geocoder-icon geocoder-icon-search";var n=this._inputEl=document.createElement("input");n.type="text";n.placeholder=this.options.placeholder;n.addEventListener("keydown",a(function(t){if(!t.target.value)return this._clearEl.classList.remove("active");t.metaKey||[9,27,37,39,13,38,40].indexOf(t.keyCode)!==-1||this._queryFromInput(t.target.value)}.bind(this)),200);n.addEventListener("change",function(e){e.target.value&&this._clearEl.classList.add("active");var i=this._typeahead.selected;if(i){if(this.options.flyTo)if(i.bbox&&i.context&&i.context.length<=3||i.bbox&&!i.context){var n=i.bbox;t.fitBounds([[n[0],n[1]],[n[2],n[3]]])}else t.flyTo({center:i.center,zoom:this.options.zoom});this._input=i;this.fire("result",{result:i})}}.bind(this));var o=document.createElement("div");o.classList.add("geocoder-pin-right");var r=this._clearEl=document.createElement("button");r.className="geocoder-icon geocoder-icon-close";r.addEventListener("click",this._clear.bind(this));var c=this._loadingEl=document.createElement("span");c.className="geocoder-icon geocoder-icon-loading";o.appendChild(r);o.appendChild(c);e.appendChild(i);e.appendChild(n);e.appendChild(o);this.options.container&&(this.options.position=false);this._typeahead=new s(n,[],{filter:false});this._typeahead.getItemValue=function(t){return t.place_name};return e}_geocode(t,e){this._loadingEl.classList.add("active");this.fire("loading");const i=this.options;const n=["placeholder","zoom","flyTo","accessToken","api"];const o=Object.keys(this.options).filter((function(t){return n.indexOf(t)===-1})).map((function(t){return t+"="+i[t]}));var r=this.options.accessToken?this.options.accessToken:mapboxgl.accessToken;o.push("access_token="+r);this.request.abort();this.request.open("GET",this.api+encodeURIComponent(t.trim())+".json?"+o.join("&"),true);this.request.onload=function(){this._loadingEl.classList.remove("active");if(this.request.status>=200&&this.request.status<400){var t=JSON.parse(this.request.responseText);if(t.features.length)this._clearEl.classList.add("active");else{this._clearEl.classList.remove("active");this._typeahead.selected=null}this.fire("results",{results:t.features});this._typeahead.update(t.features);return e(t.features)}this.fire("error",{error:JSON.parse(this.request.responseText).message})}.bind(this);this.request.onerror=function(){this._loadingEl.classList.remove("active");this.fire("error",{error:JSON.parse(this.request.responseText).message})}.bind(this);this.request.send()}_queryFromInput(t){t=t.trim();t||this._clear();t.length>2&&this._geocode(t,function(t){this._results=t}.bind(this))}_change(){var t=document.createEvent("HTMLEvents");t.initEvent("change",true,false);this._inputEl.dispatchEvent(t)}_query(t){if(t){typeof t==="object"&&t.length&&(t=[p.wrap(t[0]),p.wrap(t[1])].join());this._geocode(t,function(t){if(t.length){var e=t[0];this._results=t;this._typeahead.selected=e;this._inputEl.value=e.place_name;this._change()}}.bind(this))}}_setInput(t){if(t){typeof t==="object"&&t.length&&(t=[p.roundWithOriginalPrecision(p.wrap(t[0]),t[0]),p.roundWithOriginalPrecision(p.wrap(t[1]),t[1])].join());this._inputEl.value=t;this._input=null;this._typeahead.selected=null;this._typeahead.clear();this._change()}}_clear(){this._input=null;this._inputEl.value="";this._typeahead.selected=null;this._typeahead.clear();this._change();this._inputEl.focus();this._clearEl.classList.remove("active");this.fire("clear")}getResult(){return this._input}
/**
   * Set & query the input
   * @param {Array|String} query An array of coordinates [lng, lat] or location name as a string.
   * @returns {Geocoder} this
   */query(t){this._query(t);return this}
/**
   * Set input
   * @param {Array|String} value An array of coordinates [lng, lat] or location name as a string. Calling this function just sets the input and does not trigger an API request.
   * @returns {Geocoder} this
   */setInput(t){this._setInput(t);return this}
/**
   * Subscribe to events that happen within the plugin.
   * @param {String} type name of event. Available events and the data passed into their respective event objects are:
   *
   * - __clear__ `Emitted when the input is cleared`
   * - __loading__ `Emitted when the geocoder is looking up a query`
   * - __results__ `{ results } Fired when the geocoder returns a response`
   * - __result__ `{ result } Fired when input is set`
   * - __error__ `{ error } Error as string`
   * @param {Function} fn function that's called when the event is emitted.
   * @returns {Geocoder} this;
   */on(t,e){this._ev.on(t,e);this._ev.on("error",(function(t){console.log(t)}));return this}
/**
   * Fire an event
   * @param {String} type event name.
   * @param {Object} data event data to pass to the function subscribed.
   * @returns {Geocoder} this
   */fire(t,e){this._ev.emit(t,e);return this}
/**
   * Remove an event
   * @returns {Geocoder} this
   * @param {String} type Event name.
   * @param {Function} fn Function that should unsubscribe to the event emitted.
   */off(t,e){this._ev.removeListener(t,e);return this}}let M=require("fs");let P=u(M.readFileSync(__dirname+"/../templates/inputs.html","utf8"));
/**
 * Inputs controller
 *
 * @param {HTMLElement} el Summary parent container
 * @param {Object} store A redux store
 * @param {Object} actions Actions an element can dispatch
 * @param {Object} map The mapboxgl instance
 * @private
 */class Inputs{constructor(t,e,i,n){const{originQuery:o,destinationQuery:r,profile:s,controls:a}=e.getState();t.innerHTML=P({originQuery:o,destinationQuery:r,profile:s,controls:a});this.container=t;this.actions=i;this.store=e;this._map=n;this.onAdd();this.render()}animateToCoordinates(t,e){const{origin:i,destination:n,routePadding:o}=this.store.getState();if(i.geometry&&n.geometry&&!l(i.geometry,n.geometry)){const t=d({type:"FeatureCollection",features:[i,n]});this._map.fitBounds([[t[0],t[1]],[t[2],t[3]]],{padding:o})}else this._map.flyTo({center:e})}onAdd(){const{clearOrigin:t,clearDestination:e,createOrigin:i,createDestination:n,setProfile:o,reverse:r}=this.actions;const{geocoder:s,accessToken:a,flyTo:c,placeholderOrigin:u,placeholderDestination:l,zoom:d}=this.store.getState();this.originInput=new Geocoder(Object.assign({},{accessToken:a},s,{flyTo:c,placeholder:u,zoom:d}));const h=this.originInput.onAdd(this._map);const p=this.container.querySelector("#mapbox-directions-origin-input");p.appendChild(h);this.destinationInput=new Geocoder(Object.assign({},{accessToken:a},s,{flyTo:c,placeholder:l,zoom:d}));const g=this.destinationInput.onAdd(this._map);this.container.querySelector("#mapbox-directions-destination-input").appendChild(g);this.originInput.on("result",(t=>{const e=t.result.center;i(e);this.animateToCoordinates("origin",e)}));this.originInput.on("clear",t);this.destinationInput.on("result",(t=>{const e=t.result.center;n(e);this.animateToCoordinates("destination",e)}));this.destinationInput.on("clear",e);const m=this.container.querySelectorAll('input[type="radio"]');Array.prototype.forEach.call(m,(t=>{t.addEventListener("change",(()=>{o(t.value)}))}));this.container.querySelector(".js-reverse-inputs").addEventListener("click",(()=>{const{origin:t,destination:e}=this.store.getState();t&&this.actions.queryDestination(t.geometry.coordinates);e&&this.actions.queryOrigin(e.geometry.coordinates);r()}))}render(){this.store.subscribe((()=>{const{originQuery:t,destinationQuery:e,originQueryCoordinates:i,destinationQueryCoordinates:n}=this.store.getState();if(t){this.originInput.query(t);this.actions.queryOrigin(null)}if(e){this.destinationInput.query(e);this.actions.queryDestination(null)}if(i){this.originInput.setInput(i);this.animateToCoordinates("origin",i);this.actions.queryOriginCoordinates(null)}if(n){this.destinationInput.setInput(n);this.animateToCoordinates("destination",n);this.actions.queryDestinationCoordinates(null)}}))}}let N=require("fs");let L=u(N.readFileSync(__dirname+"/../templates/instructions.html","utf8"));let j=u(N.readFileSync(__dirname+"/../templates/error.html","utf8"));
/**
 * Summary/Instructions controller
 *
 * @param {HTMLElement} el Summary parent container
 * @param {Object} store A redux store
 * @param {Object} actions Actions an element can dispatch
 * @param {Object} map The mapboxgl instance
 * @private
 */class Instructions{constructor(t,e,i,n){this.container=t;this.actions=i;this.store=e;this._map=n;this.directions={};this.render()}render(){this.store.subscribe((()=>{const{hoverMarker:t,setRouteIndex:e}=this.actions;const{routeIndex:i,unit:n,directions:o,error:r,compile:s,instructions:a}=this.store.getState();const c=!l(o[i],this.directions);if(r){this.container.innerHTML=j({error:r});return}const u=a.showWaypointInstructions?void 0:t=>t.maneuver.type!=="waypoint";if(o.length&&c){const r=this.directions=o[i];const a=p.getAllSteps(r,u);s&&r.legs.forEach((function(t){t.steps.forEach((function(t){t.maneuver.instruction=s("en",t)}))}));this.container.innerHTML=L({routeIndex:i,routes:o.length,steps:a,format:p.format[n],duration:p.format.duration(r.duration),distance:p.format[n](r.distance)});const c=this.container.querySelectorAll(".mapbox-directions-step");Array.prototype.forEach.call(c,(e=>{const i=e.getAttribute("data-lng");const n=e.getAttribute("data-lat");e.addEventListener("mouseover",(()=>{t([i,n])}));e.addEventListener("mouseout",(()=>{t(null)}));e.addEventListener("click",(()=>{this._map.flyTo({center:[i,n],zoom:16})}))}));const l=this.container.querySelectorAll('input[type="radio"]');Array.prototype.forEach.call(l,(t=>{t.addEventListener("change",(t=>{e(parseInt(t.target.id,10))}))}))}else this.container.innerHTML&&c&&(this.container.innerHTML="")}))}}
/**
 * The Directions control
 * @class MapboxDirections
 *
 * @param {Object} options
 * @param {Array} [options.styles] Override default layer properties of the [directions source](https://github.com/mapbox/mapbox-gl-directions/blob/master/src/directions_style.js). Documentation for each property are specified in the [Mapbox GL Style Reference](https://www.mapbox.com/mapbox-gl-style-spec/).
 * @param {String} [options.accessToken=null] Required unless `mapboxgl.accessToken` is set globally
 * @param {String} [options.api="https://api.mapbox.com/directions/v5/"] Override default routing endpoint url
 * @param {Boolean} [options.interactive=true] Enable/Disable mouse or touch interactivity from the plugin
 * @param {String} [options.profile="mapbox/driving-traffic"] Routing profile to use. Options: `mapbox/driving-traffic`, `mapbox/driving`, `mapbox/walking`, `mapbox/cycling`
 * @param {Boolean} [options.alternatives=false] Whether to enable alternatives.
 * @param {Boolean} [options.congestion=false] Whether to enable congestion along the route line.
 * @param {String} [options.unit="imperial"] Measurement system to be used in navigation instructions. Options: `imperial`, `metric`
 * @param {Function} [options.compile=null] Provide a custom function for generating instruction, compatible with osrm-text-instructions.
 * @param {Object} [options.geocoder] Accepts an object containing the query parameters as [documented here](https://www.mapbox.com/api-documentation/#search-for-places).
 * @param {Object} [options.controls]
 * @param {Boolean} [options.controls.inputs=true] Hide or display the inputs control.
 * @param {Boolean} [options.controls.instructions=true] Hide or display the instructions control.
 * @param {Boolean} [options.controls.profileSwitcher=true] Hide or display the default profile switch with options for traffic, driving, walking and cycling.
 * @param {Object} [options.instructions]
 * @param {Boolean} [options.instructions.showWaypointInstructions=true] Hide or display instructions for waypoints in the route
 * @param {Number} [options.zoom=16] If no bbox exists from the geocoder result, the zoom you set here will be used in the flyTo.
 * @param {String} [options.language="en"] The language of returned turn-by-turn text instructions. See supported languages : https://docs.mapbox.com/api/navigation/#instructions-languages
 * @param {String} [options.placeholderOrigin="Choose a starting place"] If set, this text will appear as the placeholder attribute for the origin input element.
 * @param {String} [options.placeholderDestination="Choose destination"] If set, this text will appear as the placeholder attribute for the destination input element.
 * @param {Boolean} [options.flyTo=true] If false, animating the map to a selected result is disabled.
 * @param {String} [options.exclude=null] Exclude certain road types from routing. The default is to not exclude anything. Search for `exclude` in `optional parameters`: https://docs.mapbox.com/api/navigation/#retrieve-directions
 * @param {number | PaddingOptions} [options.routePadding=80] Specify padding surrounding route. A single number of pixels or a [PaddingOptions](https://docs.mapbox.com/mapbox-gl-js/api/#paddingoptions) object.
 * @example
 * var MapboxDirections = require('../src/index');
 * var directions = new MapboxDirections({
 *   accessToken: 'YOUR-MAPBOX-ACCESS-TOKEN',
 *   unit: 'metric',
 *   profile: 'mapbox/cycling'
 * });
 * // add to your mapboxgl map
 * map.addControl(directions);
 *
 * @return {MapboxDirections} `this`
 */class MapboxDirections{constructor(e){this._store=this._initStore();this.actions=t(T,this._store.dispatch);this.actions.setOptions(e||{});this.options=e||{};this.onDragDown=this._onDragDown.bind(this);this.onDragMove=this._onDragMove.bind(this);this.onDragUp=this._onDragUp.bind(this);this.move=this._move.bind(this);this.onClick=this._clickHandler().bind(this)}onAdd(t){this._map=t;const{controls:e}=this._store.getState();var i=this.container=document.createElement("div");i.className="mapboxgl-ctrl-directions mapboxgl-ctrl";const n=document.createElement("div");n.className="directions-control directions-control-inputs";new Inputs(n,this._store,this.actions,this._map);const o=document.createElement("div");o.className="directions-control directions-control-instructions";new Instructions(o,this._store,{hoverMarker:this.actions.hoverMarker,setRouteIndex:this.actions.setRouteIndex},this._map);e.inputs&&i.appendChild(n);e.instructions&&i.appendChild(o);this.subscribedActions();this._map.loaded()?this.mapState():this._map.on("load",(()=>this.mapState()));return i}
/**
   * Removes the control from the map it has been added to. This is called by `map.removeControl`,
   * which is the recommended method to remove controls.
   *
   * @returns {Control} `this`
   */onRemove(t){this.container.parentNode.removeChild(this.container);this.removeRoutes();t.off("mousedown",this.onDragDown);t.off("mousemove",this.move);t.off("touchstart",this.onDragDown);t.off("touchstart",this.move);t.off("click",this.onClick);if(this.storeUnsubscribe){this.storeUnsubscribe();delete this.storeUnsubscribe}R.forEach((e=>{t.getLayer(e.id)&&t.removeLayer(e.id)}));t.getSource("directions")&&t.removeSource("directions");this._map=null;return this}mapState(){const{profile:t,alternatives:e,congestion:i,styles:n,interactive:o,compile:r}=this._store.getState();this.actions.eventEmit("profile",{profile:t});const s={type:"geojson",data:{type:"FeatureCollection",features:[]}};this._map.addSource("directions",s);n&&n.length&&n.forEach((t=>this._map.addLayer(t)));R.forEach((t=>{this._map.getLayer(t.id)||this._map.addLayer(t)}));if(o){this._map.on("mousedown",this.onDragDown);this._map.on("mousemove",this.move);this._map.on("click",this.onClick);this._map.on("touchstart",this.move);this._map.on("touchstart",this.onDragDown)}}subscribedActions(){this.storeUnsubscribe=this._store.subscribe((()=>{const{origin:t,destination:e,hoverMarker:i,directions:n,routeIndex:r}=this._store.getState();const s={type:"FeatureCollection",features:[t,e,i].filter((t=>t.geometry))};n.length&&n.forEach(((t,e)=>{const i=[];const n=o(t.geometry,5).map((function(t){return t.reverse()}));const a=p.getAllSteps(t);n.forEach((function(n,o){var s=i[i.length-1];var a=t.legs[0].annotation&&t.legs[0].annotation.congestion&&t.legs[0].annotation.congestion[o-1];if(!s||a&&s.properties.congestion!==a){var c={geometry:{type:"LineString",coordinates:[]},properties:{"route-index":e,route:e===r?"selected":"alternate"}};s&&c.geometry.coordinates.push(s.geometry.coordinates[s.geometry.coordinates.length-1]);c.geometry.coordinates.push(n);a&&(c.properties.congestion=t.legs[0].annotation.congestion[o-1]);i.push(c)}else s.geometry.coordinates.push(n)}));s.features=s.features.concat(i);e===r&&a.forEach((t=>{t.maneuver.type==="waypoint"&&s.features.push({type:"Feature",geometry:{type:"Point",coordinates:t.maneuver.location},properties:{id:"waypoint"}})}))}));this._map.style&&this._map.getSource("directions")&&this._map.getSource("directions").setData(s)}))}_initStore(){const t=i(n)(e);return t(data)}_clickHandler(){var t=null;var e=250;return function(i){if(t){clearTimeout(t);t=null;this._map.zoomIn()}else{var n=this._onSingleClick.bind(this);t=setTimeout((function(){n(i);t=null}),e)}}}_onSingleClick(t){const{origin:e}=this._store.getState();const i=[t.lngLat.lng,t.lngLat.lat];if(e.geometry){const e=this._map.queryRenderedFeatures(t.point,{layers:["directions-origin-point","directions-destination-point","directions-waypoint-point","directions-route-line-alt"]});if(e.length){e.forEach((t=>{t.layer.id==="directions-waypoint-point"&&this.actions.removeWaypoint(t)}));if(e[0].properties.route==="alternate"){const t=e[0].properties["route-index"];this.actions.setRouteIndex(t)}}else{this.actions.setDestinationFromCoordinates(i);this._map.flyTo({center:i})}}else this.actions.setOriginFromCoordinates(i)}_move(t){const{hoverMarker:e}=this._store.getState();const i=this._map.queryRenderedFeatures(t.point,{layers:["directions-route-line-alt","directions-route-line","directions-origin-point","directions-destination-point","directions-hover-point"]});this._map.getCanvas().style.cursor=i.length?"pointer":"";if(i.length){this.isCursorOverPoint=i[0];this._map.dragPan.disable();i.forEach((i=>{i.layer.id==="directions-route-line"?this.actions.hoverMarker([t.lngLat.lng,t.lngLat.lat]):e.geometry&&this.actions.hoverMarker(null)}))}else if(this.isCursorOverPoint){this.isCursorOverPoint=false;this._map.dragPan.enable()}}_onDragDown(){if(this.isCursorOverPoint){this.isDragging=this.isCursorOverPoint;this._map.getCanvas().style.cursor="grab";this._map.on("mousemove",this.onDragMove);this._map.on("mouseup",this.onDragUp);this._map.on("touchmove",this.onDragMove);this._map.on("touchend",this.onDragUp)}}_onDragMove(t){if(!this.isDragging)return;const e=[t.lngLat.lng,t.lngLat.lat];switch(this.isDragging.layer.id){case"directions-origin-point":this.actions.createOrigin(e);break;case"directions-destination-point":this.actions.createDestination(e);break;case"directions-hover-point":this.actions.hoverMarker(e);break}}_onDragUp(){if(!this.isDragging)return;const{hoverMarker:t,origin:e,destination:i}=this._store.getState();switch(this.isDragging.layer.id){case"directions-origin-point":this.actions.setOriginFromCoordinates(e.geometry.coordinates);break;case"directions-destination-point":this.actions.setDestinationFromCoordinates(i.geometry.coordinates);break;case"directions-hover-point":t.geometry&&!p.coordinateMatch(this.isDragging,t)&&this.actions.addWaypoint(0,t);break}this.isDragging=false;this._map.getCanvas().style.cursor="";this._map.off("touchmove",this.onDragMove);this._map.off("touchend",this.onDragUp);this._map.off("mousemove",this.onDragMove);this._map.off("mouseup",this.onDragUp)}
/**
   * Turn on or off interactivity
   * @param {Boolean} state sets interactivity based on a state of `true` or `false`.
   * @returns {MapboxDirections} this
   */
interactive(t){if(t){this._map.on("touchstart",this.move);this._map.on("touchstart",this.onDragDown);this._map.on("mousedown",this.onDragDown);this._map.on("mousemove",this.move);this._map.on("click",this.onClick)}else{this._map.off("touchstart",this.move);this._map.off("touchstart",this.onDragDown);this._map.off("mousedown",this.onDragDown);this._map.off("mousemove",this.move);this._map.off("click",this.onClick)}return this}
/**
   * Returns the origin of the current route.
   * @returns {Object} origin
   */getOrigin(){return this._store.getState().origin}
/**
   * Sets origin. _Note:_ calling this method requires the [map load event](https://www.mapbox.com/mapbox-gl-js/api/#Map.load)
   * to have run.
   * @param {Array<number>|String} query An array of coordinates [lng, lat] or location name as a string.
   * @returns {MapboxDirections} this
   */setOrigin(t){typeof t==="string"?this.actions.queryOrigin(t):this.actions.setOriginFromCoordinates(t);return this}
/**
   * Returns the destination of the current route.
   * @returns {Object} destination
   */getDestination(){return this._store.getState().destination}
/**
   * Sets destination. _Note:_ calling this method requires the [map load event](https://www.mapbox.com/mapbox-gl-js/api/#Map.load)
   * to have run.
   * @param {Array<number>|String} query An array of coordinates [lng, lat] or location name as a string.
   * @returns {MapboxDirections} this
   */setDestination(t){typeof t==="string"?this.actions.queryDestination(t):this.actions.setDestinationFromCoordinates(t);return this}
/**
   * Swap the origin and destination.
   * @returns {MapboxDirections} this
   */reverse(){this.actions.reverse();return this}
/**
   * Add a waypoint to the route. _Note:_ calling this method requires the
   * [map load event](https://www.mapbox.com/mapbox-gl-js/api/#Map.load) to have run.
   * @param {Number} index position waypoint should be placed in the waypoint array
   * @param {Array<number>|Point} waypoint can be a GeoJSON Point Feature or [lng, lat] coordinates.
   * @returns {MapboxDirections} this;
   */addWaypoint(t,e){e.type||(e=p.createPoint(e,{id:"waypoint"}));this.actions.addWaypoint(t,e);return this}
/**
   * Change the waypoint at a given index in the route. _Note:_ calling this
   * method requires the [map load event](https://www.mapbox.com/mapbox-gl-js/api/#Map.load)
   * to have run.
   * @param {Number} index indexed position of the waypoint to update
   * @param {Array<number>|Point} waypoint can be a GeoJSON Point Feature or [lng, lat] coordinates.
   * @returns {MapboxDirections} this;
   */setWaypoint(t,e){e.type||(e=p.createPoint(e,{id:"waypoint"}));this.actions.setWaypoint(t,e);return this}
/**
   * Remove a waypoint from the route.
   * @param {Number} index position in the waypoints array.
   * @returns {MapboxDirections} this;
   */removeWaypoint(t){const{waypoints:e}=this._store.getState();this.actions.removeWaypoint(e[t]);return this}
/**
   * Fetch all current waypoints in a route.
   * @returns {Array} waypoints
   */getWaypoints(){return this._store.getState().waypoints}
/**
   * Removes all routes and waypoints from the map.
   *
   * @returns {MapboxDirections} this;
   */removeRoutes(){this.actions.clearOrigin();this.actions.clearDestination();return this}
/**
   * Subscribe to events that happen within the plugin.
   * @param {String} type name of event. Available events and the data passed into their respective event objects are:
   *
   * - __clear__ `{ type: } Type is one of 'origin' or 'destination'`
   * - __loading__ `{ type: } Type is one of 'origin' or 'destination'`
   * - __profile__ `{ profile } Profile is one of 'driving', 'walking', or 'cycling'`
   * - __origin__ `{ feature } Fired when origin is set`
   * - __destination__ `{ feature } Fired when destination is set`
   * - __route__ `{ route } Fired when a route is updated`
   * - __error__ `{ error } Error as string`
   * @param {Function} fn function that's called when the event is emitted.
   * @returns {MapboxDirections} this;
   */on(t,e){this.actions.eventSubscribe(t,e);return this}}module.exports=MapboxDirections;

