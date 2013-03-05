# 60,000+ UFO Sightings from the National UFO Reporting Center

More than 60,000 accounts of UFO sightings, including detailed eye-witness descriptions, location, date reported and sighted, duration and shape. The data comes from the National UFO Reporting Center.

### Fields

Schema:

    field :sighted_at,   :time
    field :reported_at,  :time
    field :shape,        :symbol
    field :duration,     :string
    field :description,  :string
    field :location,     Wu::Geo::Place
    field :coordinates,  :array, of: :float
    field :location_str, :string

Example:

    { "sighted_at":"2007-03-08T06:00:00Z",
      "reported_at":"2007-03-09T06:00:00Z",
      "shape":"disk", "duration":"4 min",
      "description":"Second sighting of oval/disk metallic objectSighting Report Thursday, March 8, 2007  On smoke break facing southeast on Rockville Pike I again saw a disk/oval shaped craft flying in a southeast direction.  It was about the height on my sixth floor of my office building.  This was the second sighting of this same object that I saw in January 2007.  Once again, it was oval/disk shaped highly polished silver on one half and highly polished cherry red color on the other half.  It again, tumbled occassionaly and I was able to see the bright reflection of the 2 halves.A man who works on the 7th floor was outside and I called to him to come here, hurry.  He came over to me quickly and I pointed to the object in the sky and said, what is that?  He looked and said Oh my goodness what is it?  Is it a ufo?  I said it probably is maybe a probe or some type of spying device.  It made no sound and quickly flew out of our sight.  As an aside, when I drove to work that morning, around 7:55 I saw 2 helicopters flying north following Route 355 in Rockville.",
      "location":{"place_type":"administrative","place_id":"98162850","osm_id":133700,"latitude":39.0840054,"longitude":-77.1527573,"city":"Rockville","county":"Montgomery County","state":"Maryland","country":"United States of America","bbox":[-77.2003021240234,39.053150177002,-77.1077423095703,39.1204452514648]},
      "coordinates":[-77.1527573,39.0840054],"location_str":"Rockville, MD",}
