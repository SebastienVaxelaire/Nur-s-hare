import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
import * as turf from "@turf/turf"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.on("style.load", () => {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
      this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl }))
    })
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      const center = [Number(marker.lng), Number(marker.lat)]

      if (marker.rad) {
        const radius = marker.rad
        const options = { steps: 50, units: 'kilometers' }
        const circle = turf.circle(center, radius, options)

        const polygonCoordinates = circle.geometry.coordinates[0].map(coord => [Number(coord[0]), Number(coord[1])])

        const polygonFeature = {
          type: 'Feature',
          geometry: {
            type: 'Polygon',
            coordinates: [polygonCoordinates]
          },
          properties: {}
        }

        this.map.addLayer({
          id: `circle-${marker.id}`,
          type: 'fill',
          source: {
            type: 'geojson',
            data: polygonFeature
          },
          paint: {
            'fill-color': 'rgba(211, 211, 211, 0.3)', // Light grey color with diminished opacity
            'fill-outline-color': '#ffffff' // White color for the outline
          },
          layout: {
            visibility: 'none' // Initially hide the layer
          }
        })
      }

      new mapboxgl.Marker(customMarker)
        .setLngLat(center)
        .setPopup(popup)
        .addTo(this.map)
        .getElement()
        .addEventListener('mouseenter', () => {
          if (marker.rad) {
            this.map.setLayoutProperty(`circle-${marker.id}`, 'visibility', 'visible')
          }
        })

      customMarker.addEventListener('mouseleave', () => {
        if (marker.rad) {
          this.map.setLayoutProperty(`circle-${marker.id}`, 'visibility', 'none')
        }
      })
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([Number(marker.lng), Number(marker.lat)]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
