import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
  const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const geolocate = new mapboxgl.GeolocateControl({
  positionOptions: {
  enableHighAccuracy: true
  },
  trackUserLocation: true,
  fitBoundsOptions: { maxZoom:10, duration:30 }
});

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10?optimize=true',
      center: [2.33, 48.85], // Coordonées de Paris par défaut
      zoom: 11
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl, placeholder: 'Entrez une adresse', zoom: 11 }));
    map.addControl(geolocate);
    // map.fitBounds(bounds, { padding: 30, zoom: 11, duration: 0 });
    map.on("load", function (e) {
        const mapContainerEl = document.getElementById("map");
        mapContainerEl.style.visibility = "visible";
    });
  }
};

export { initMapbox };

// TEST

// const fitMapToMarkers = (map, markers) => {
//   // const bounds = new mapboxgl.LngLatBounds();
//   // markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
//   // map.fitBounds(bounds, { padding: 30, zoom: 11, duration: 0 });
//   var map = new mapboxgl.Map({
//         container: 'map',
//         style: 'mapbox://styles/mapbox/streets-v10',
//         center: [2.32, 48.93],
//         zoom: 9,
//         // attributionControl: false
//     });
//     // map.addControl(new mapboxgl.AttributionControl(), 'top-left');
// };
