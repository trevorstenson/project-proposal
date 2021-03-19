API_KEY="AIzaSyBZEU9BhosOdMNLtPaMYeq8T_Tip31FLh0"

let map;

// basic.html
function initMap() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 42.361145, lng: -71.057083 },
    zoom: 13
  });
}

// geolocation.html
function initMapWithGeolocation() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 42.361145, lng: -71.057083 },
    zoom: 13
  });
  const geolocateButton = document.createElement("button");
  geolocateButton.textContent = "Locate me";
  geolocateButton.classList.add("custom-map-control-button");
  map.controls[google.maps.ControlPosition.TOP_CENTER].push(geolocateButton);
  geolocateButton.addEventListener("click", () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          addMarker(pos, 'https://img.icons8.com/fluent/48/000000/airplane-take-off.png')
          map.setCenter(pos);
        }
      )
    }
  });
}

function addMarker(pos, icon) {
  return new google.maps.Marker({
    position: pos,
    map: map,
    icon: icon
  })
}

function initMapWithMarkers() {
  map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 42.361145, lng: -71.057083 },
    zoom: 13
  });
  const latField = document.getElementById("lat");
  const lngField = document.getElementById("lng");
  const markerButton = document.getElementById("positionButton");
  markerButton.addEventListener("click", () => {
    let latValue = parseFloat(latField.value);
    let lngValue = parseFloat(lngField.value);
    let newPos = {
      lat: latValue,
      lng: lngValue
    }
    addMarker(newPos, 'https://img.icons8.com/fluent/48/000000/airplane-take-off.png');
    map.setCenter(newPos);
  });
}