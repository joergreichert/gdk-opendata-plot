const circle = require("@turf/circle").default;
const fs = require("fs");

function transform(year) {
  fs.readFile(`../data/${year}/wateredTreesSum_MidSep.geojson`, "utf8", (err, jsonString) => {
    if (err) {
      console.log("File read failed:", err);
      return;
    }
    const geoJson = JSON.parse(jsonString);
    var features = geoJson.features;
    console.log(`count ${features.length}`)
    const transformedFeatures = features.map(feature => {
      var center = feature.geometry.coordinates;
      var radius = 1;
      var options = {steps: 10, units: 'meters', properties: { wassersumme: Number(feature.properties.wassersumme) } };
      return circle(center, radius, options)
    });
    const transformedGeoJson = {
        "type": "FeatureCollection",
        "features": transformedFeatures
    };
    fs.writeFile(`../data/${year}/treesExtrusion.geojson`, JSON.stringify(transformedGeoJson), function(err) {
      if(err) {
        console.log("File write failed:", err);
        return;
      }
      console.log("The file was saved!");
    });
  });  
}

const args = process.argv;
transform(args.length > 2 ? args[2] : 2023);
