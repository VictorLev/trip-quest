
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
//import MapboxDirections from '@mapbox/mapbox-gl-directions'

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = ["startpoint", "endpoint", "form", "button", "map", "checkbox", "reward"];

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

    this.direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      unit: 'metric',
      profile: 'mapbox/driving',
      optimizeWaypoints: true,
    })

    this.map.addControl(
      this.direction,
      'top-right'
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

  calculate() {

    this.#removeAllWayPoints()

    // Check if the direction has been set
    if ( Object.keys(this.direction.getOrigin()).length !== 0 && Object.keys(this.direction.getDestination()).length !== 0) {
      // calculate the reward
      let reward = 0
      this.checkboxTargets.forEach((checkbox, index) => {
        if (checkbox.checked) {
          const labelElement = document.querySelector('label[for="' + checkbox.id + '"]');
          reward += parseInt(labelElement.innerText.split(' ').slice(-1)[0]);
          const checkboxid = parseInt(checkbox.id.split('_').slice(-1)[0]);

          const wayPoint = this.markersValue.filter((marker) => marker.id === checkboxid)[0];
          // Add waypoints
          console.log(wayPoint);
          this.direction.addWaypoint(index, [ wayPoint.lng, wayPoint.lat ]);
        }
      })

      // Update the reward target
      this.rewardTarget.innerText = reward;
    }
  }

  #removeAllWayPoints() {
    // Get the number of waypoints
    const numberOfWaypoints = this.direction.getWaypoints().length;

    // Loop through each waypoint and remove it
    for (let i = 0; i < numberOfWaypoints; i++) {
      this.direction.removeWaypoint(i);
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.sp_info_html)
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
