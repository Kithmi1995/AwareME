$(function () {

    var parameters = {};

    var marker;

    function initMap() {
        var lat = typeof parameters.lat == 'undefined'?6.9215427:parameters.lat;
        var lng = typeof parameters.lng == 'undefined'?79.7862609:parameters.lng;

        /*var lat = 50.0875726;
        var lng = 14.4189987;*/

        var location = new google.maps.LatLng(lat, lng);

        var mapCanvas = document.getElementById('map');
        var mapOptions = {
            center: location,
            zoom: 16,
            panControl: true,
            scrollwheel: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(mapCanvas, mapOptions);

        var markerImage = 'marker.png';

        marker = new google.maps.Marker({
            position: location,
            map: map,
            icon: markerImage
        });

        var contentString = '<div class="info-window">' +
            '<h3>Information</h3>' +
            '<div class="info-content">' +
            '<p> lat: ' +lat +
                ' long : '+lng+' '+
            '</p>' +
            '</div>' +
            '</div>';

        var infowindow = new google.maps.InfoWindow({
            content: contentString,
            maxWidth: 400
        });

        marker.addListener('click', function () {
            infowindow.open(map, marker);

            /*marker.setIcon("marker.png");
            infowindow.open(map);*/
        });

        google.maps.event.addListener(marker, 'click', function() {
             marker.setIcon("marker.png");
             infowindow.open(map);
         });

        var styles = [{"featureType": "landscape", "stylers": [{"saturation": -100}, {"lightness": 65}, {"visibility": "on"}]}, {"featureType": "poi", "stylers": [{"saturation": -100}, {"lightness": 51}, {"visibility": "simplified"}]}, {"featureType": "road.highway", "stylers": [{"saturation": -100}, {"visibility": "simplified"}]}, {"featureType": "road.arterial", "stylers": [{"saturation": -100}, {"lightness": 30}, {"visibility": "on"}]}, {"featureType": "road.local", "stylers": [{"saturation": -100}, {"lightness": 40}, {"visibility": "on"}]}, {"featureType": "transit", "stylers": [{"saturation": -100}, {"visibility": "simplified"}]}, {"featureType": "administrative.province", "stylers": [{"visibility": "off"}]}, {"featureType": "water", "elementType": "labels", "stylers": [{"visibility": "on"}, {"lightness": -25}, {"saturation": -100}]}, {"featureType": "water", "elementType": "geometry", "stylers": [{"hue": "#ffff00"}, {"lightness": -25}, {"saturation": -97}]}];

        map.set('styles', styles);

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                // infoWindow.setPosition(pos);
                // infoWindow.setContent('Location found.');
                // infoWindow.open(map);
                map.setCenter(pos);
            }, function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }

    }

    google.maps.event.addDomListener(window, 'load', initMap);

    /*google.maps.event.addListener(marker, 'click', function() {
        marker.setIcon("marker.png");
        infowindow.open(map);
    });*/


    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };

            parameters.lat = pos.lat;
            parameters.lng = pos.lng;
            // initMap(pos.lat, pos.lng);
            // infoWindow.setPosition(pos);
            // infoWindow.setContent('Loca1tion found.');
            // infoWindow.open(map);
            // map.setCenter(pos);
            initMap();
            // google.maps.event.addDomListener(window, 'load', initMap);

        }, function() {
            // handleLocationError(true, infoWindow, map.getCenter());
        });
    } else {
        // Browser doesn't support Geolocation
        // handleLocationError(false, infoWindow, map.getCenter());
    }

});