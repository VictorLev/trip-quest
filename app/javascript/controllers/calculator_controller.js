import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
//import MapboxDirections from '@mapbox/mapbox-gl-directions'

// Connects to data-controller="calculator"
export default class extends Controller {
  static targets = ["form"]

  static values = {
    apiKey: String,
    markers: Array,
    userId: Number
  }

  connect() {
    console.log("we are connected")
    mapboxgl.accessToken = this.apiKeyValue

    console.log("we are connected")

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

  save() {
    console.log('save')
    const url = `/users/${this.userIdValue}/planned_routes/`;

    const postData = {
      planned_route: {
        start_point: `[${this.direction.getOrigin().geometry.coordinates.toString()}]`,
        end_point: `[${this.direction.getDestination().geometry.coordinates.toString()}]`,
        name: "test"
      }
    };

    const options = {
      method: 'POST',
      headers: {
        "Accept": "text/plain" // Set the content type based on your API requirements
      },
      body: new FormData(this.formTarget) // Convert the data to JSON format
    };

    fetch(url, options)
    .then(response => response.json())
    .then(data => {
      // Handle the data returned from the server
      console.log(data);
    })
  }
}
