import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
// import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';


// Connects to data-controller="new-trip"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    console.log("text")
    mapboxgl.accessToken = this.apiKeyValue;
    const map = new mapboxgl.Map({
        container: this.element,
        // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
        style: 'mapbox://styles/mapbox/streets-v12',
        center: [-79.4512, 43.6568],
        zoom: 13
    });

    map.addControl(
        new MapboxDirections({
            accessToken: mapboxgl.accessToken
        }),
        'top-left'
    );
  }



}
