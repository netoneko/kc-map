(function() {
  var KcMap;

  KcMap = (function() {

    function KcMap(json) {
      this.json = json;
      this.data = this.json.data;
    }

    KcMap.prototype.prepare_data = function(json) {
      var country, lat, list, long, _ball, _base, _i, _len, _num, _ref, _ref1;
      this.json = json;
      this.coords_by_country = {};
      _ref = this.data;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        _ref1 = _ref[_i], country = _ref1[0], lat = _ref1[1], long = _ref1[2], _ball = _ref1[3], _num = _ref1[4];
        ((_base = this.coords_by_country)[country] || (_base[country] = [])).push([lat, long]);
      }
      return this.postcount_by_country = (function() {
        var _ref2, _results;
        _ref2 = this.coords_by_country;
        _results = [];
        for (country in _ref2) {
          list = _ref2[country];
          _results.push({
            country: country,
            size: list.length
          });
        }
        return _results;
      }).call(this);
    };

    KcMap.prototype.present_data = function() {
      return slice(this.postcount_by_country);
    };

    return KcMap;

  })();

  $(document).ready(function() {
    console.log("Init");
    return $.getJSON('http://krautchan.net/ajax/geoip/lasthour', function(data) {
      var map;
      console.log("Getting data");
      map = new KcMap(data);
      map.prepare_data();
      return map.present_data();
    });
  });

}).call(this);
