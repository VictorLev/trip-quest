import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static targets = [ "dist", "dur", "mapt"]

  static values = {
    apiKey: String,
    markers: Array,
    userId: Number,
    spoint: String,
    epoint: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.maptTarget,
      style: "mapbox://styles/mapbox/streets-v10",
      zoom: 12
    })

    const startcoor = [parseFloat(this.spointValue.split(",")[1]).toFixed(6), parseFloat(this.spointValue.split(",")[0]).toFixed(6)];
    const endcoor = [parseFloat(this.epointValue.split(",")[1]).toFixed(6), parseFloat(this.epointValue.split(",")[0]).toFixed(6)];
    const waycoor = this.#addMarkersToMap()

    //   // Set start and end markers
    // new mapboxgl.Marker().setLngLat(startcoor).addTo(this.map);
    // new mapboxgl.Marker().setLngLat(endcoor).addTo(this.map);
    console.log(startcoor)
    console.log(endcoor)
    console.log(waycoor)

    this.#displayRoute(startcoor,waycoor,endcoor)

    this.#fitMapToMarkers(startcoor,endcoor)

    // this.map.mapCavans.style.height = "100%";

  }

  // Function to display route
  #displayRoute(source, destination, waypoint) {
    const routes = []
    mapboxgl.accessToken = this.apiKeyValue
    var directionsRequest = 'https://api.mapbox.com/directions/v5/mapbox/driving/' + source + ';' + waypoint + ';' + destination + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
    console.log(directionsRequest)
    fetch(directionsRequest)
        .then(response => response.json())
        .then(data => {
            var route = data.routes[0].geometry;
            this.map.addLayer({
                id: 'route',
                type: 'line',
                source: {
                    type: 'geojson',
                    data: {
                        type: 'Feature',
                        properties: {},
                        geometry: route
                    }
                },
                layout: {
                    'line-join': 'round',
                    'line-cap': 'round'
                },
                paint: {
                    'line-color': '#007cbf',
                    'line-width': 8
                }
            });
            // Add duration and distance to the page
            this.distTarget.innerHTML = (Math.round(data.routes[0].distance / 100) / 10).toFixed(1) + " km";
            this.durTarget.innerHTML = (Math.round(data.routes[0].duration / 60)).toFixed(0) + " min";
        });


    }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
  });
  return this.markersValue.map(marker => [ marker.lng, marker.lat ]).join(';')
}

  #fitMapToMarkers(startcoor,endcoor) {
  const bounds = new mapboxgl.LngLatBounds()
  bounds.extend(startcoor)
  bounds.extend(endcoor)
  this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  this.map.fitBounds(bounds, { padding: 20, maxZoom: 12, duration: 0 })
 }
}
