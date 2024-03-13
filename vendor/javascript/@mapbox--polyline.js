var e={};var r={};function py2_round(e){return Math.floor(Math.abs(e)+.5)*(e>=0?1:-1)}function encode(e,r,n){e=py2_round(e*n);r=py2_round(r*n);var o=2*(e-r);o<0&&(o=-o-1);var t="";while(o>=32){t+=String.fromCharCode(63+(32|31&o));o/=32}t+=String.fromCharCode(63+(0|o));return t}
/**
 * Decodes to a [latitude, longitude] coordinates array.
 *
 * This is adapted from the implementation in Project-OSRM.
 *
 * @param {String} str
 * @param {Number} precision
 * @returns {Array}
 *
 * @see https://github.com/Project-OSRM/osrm-frontend/blob/master/WebContent/routing/OSRM.RoutingGeometry.js
 */r.decode=function(e,r){var n,o,t=0,i=0,a=0,u=[],d=0,c=0,f=null,h=Math.pow(10,Number.isInteger(r)?r:5);while(t<e.length){f=null;d=1;c=0;do{f=e.charCodeAt(t++)-63;c+=(31&f)*d;d*=32}while(f>=32);n=1&c?(-c-1)/2:c/2;d=1;c=0;do{f=e.charCodeAt(t++)-63;c+=(31&f)*d;d*=32}while(f>=32);o=1&c?(-c-1)/2:c/2;i+=n;a+=o;u.push([i/h,a/h])}return u};
/**
 * Encodes the given [latitude, longitude] coordinates array.
 *
 * @param {Array.<Array.<Number>>} coordinates
 * @param {Number} precision
 * @returns {String}
 */r.encode=function(e,r){if(!e.length)return"";var n=Math.pow(10,Number.isInteger(r)?r:5),o=encode(e[0][0],0,n)+encode(e[0][1],0,n);for(var t=1;t<e.length;t++){var i=e[t],a=e[t-1];o+=encode(i[0],a[0],n);o+=encode(i[1],a[1],n)}return o};function flipped(e){var r=[];for(var n=0;n<e.length;n++){var o=e[n].slice();r.push([o[1],o[0]])}return r}
/**
 * Encodes a GeoJSON LineString feature/geometry.
 *
 * @param {Object} geojson
 * @param {Number} precision
 * @returns {String}
 */r.fromGeoJSON=function(e,n){e&&"Feature"===e.type&&(e=e.geometry);if(!e||"LineString"!==e.type)throw new Error("Input must be a GeoJSON LineString");return r.encode(flipped(e.coordinates),n)};
/**
 * Decodes to a GeoJSON LineString geometry.
 *
 * @param {String} str
 * @param {Number} precision
 * @returns {Object}
 */r.toGeoJSON=function(e,n){var o=r.decode(e,n);return{type:"LineString",coordinates:flipped(o)}};e&&(e=r);var n=e;export{n as default};

