import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
//import MapboxDirections from '@mapbox/mapbox-gl-directions'

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = ["startpoint", "endpoint", "form", "button"];

  static values = {
    apiKey: String,
    markers: Array,
    userId: Number
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [144.9631, -37.8136],
      zoom: 12
    });

    this.direction = new MapboxDirections({accessToken: mapboxgl.accessToken})

    this.map.addControl(
      this.direction,
      'top-left'
    );
  }

  save(event) {
    event.preventDefault()

    // Ensure that "startpoint" target is available
    console.log(this.formTarget);

    if (!this.hasStartpointTarget) {
      console.error("Missing target element 'startpoint' for 'calculator' controller");
      return;
    }

    console.log(this.direction.getOrigin().geometry.coordinates.toString());
    console.log(this.direction.getDestination().geometry.coordinates.toString());

    // Update the values of the start and end targets
    // this.startpointTarget.value = this.direction.getOrigin().geometry.coordinates.toString();
    // this.endpointTarget.value = this.direction.getDestination().geometry.coordinates.toString();

    // Log the updated values for verification
    console.log("Start value:", this.startpointTarget.value);
    console.log("End value:", this.endpointTarget.value);

    // Submit the form
    this.formTarget.submit();
  }
}
