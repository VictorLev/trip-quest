
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
//import MapboxDirections from '@mapbox/mapbox-gl-directions'

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = ["startpoint", "endpoint", "form", "button", "map"];

  static values = {
    apiKey: String,
    markers: Array,
    userId: Number
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [144.9631, -37.8136],
      zoom: 12
    });

    this.direction = new MapboxDirections({accessToken: mapboxgl.accessToken})

    this.map.addControl(
      this.direction,
      'top-left'
    );

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  save(event) {
    event.preventDefault()

    // Update the values of the start and end targets
    this.startpointTarget.value = this.direction.getOrigin().geometry.coordinates.toString();
    this.endpointTarget.value = this.direction.getDestination().geometry.coordinates.toString();

    // Submit the form
    this.formTarget.submit();

  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.sp_info_html)
      console.log(marker)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

}
