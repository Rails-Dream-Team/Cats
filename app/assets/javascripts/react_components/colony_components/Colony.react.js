var React                = require('react');
var ReactGoogleMaps      = require('react-googlemaps');
var ExecutionEnvironment = require('react/lib/ExecutionEnvironment')
var GoogleMap            = require('../map_components/Map.react.js');
var ColonyForm           = require('./ColonyForm.react.js');
var GoogleMapsAPI        = window.google.maps;
var Map                  = ReactGoogleMaps.Map;
var geocoder             = new google.maps.Geocoder();

var Colony = React.createClass({
  render: function() {
    return this._buildColony();
  },

  _buildColony: function() {
    return (
      <div>
        <ul>
          <li>
            <div>
              <p>{this.props.data.name}</p>
              <p>{this.props.data.street_address}</p>
              <p>{this.props.data.city}</p>
              <p>{this.props.data.state}</p>
              <p>{this.props.data.zip_code}</p>
              <p>{this.props.data.environment}</p>
              <p>{this.props.data.pop}</p>
              <p>{this.props.data.vet}</p>
            </div>
          </li>
        </ul>
      </div>
    );
  }

});

module.exports = Colony;