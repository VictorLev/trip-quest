import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
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
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/driving',
      optimizeWaypoints: true,
      interactive: false,
      controls: {
        instructions: false
      }
    })
    const startcoor = [parseFloat(this.spointValue.split(",")[1]).toFixed(6), parseFloat(this.spointValue.split(",")[0]).toFixed(6)];
    const endcoor = [parseFloat(this.epointValue.split(",")[1]).toFixed(6), parseFloat(this.epointValue.split(",")[0]).toFixed(6)];
    this.direction.setOrigin(startcoor);
    this.direction.setDestination(endcoor);

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker, index) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
      this.direction.addWaypoint(index, [ marker.lng, marker.lat ]);
  });
}

  #fitMapToMarkers() {
  const bounds = new mapboxgl.LngLatBounds()
  this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
 }
}
