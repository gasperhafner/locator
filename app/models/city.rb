class City < ApplicationRecord
  has_many :push_logs, dependent: :destroy
  has_many :path_cities, dependent: :destroy
  # Spatial representation ID, do not change.
  DEFAULT_SRID = 4326

  def self.get_by_location(latitude, longitude)
    query = <<-EOS.strip_heredoc
      ST_Contains(
        cities.polygon,
        ST_Transform(
          ST_GeomFromText('POINT(:longitude :latitude)', :srid), :srid
        )
      )
    EOS

    where(
      query,
      srid: DEFAULT_SRID,
      longitude: longitude,
      latitude: latitude
    ).order(surface: :asc).first
  end

  def geojson=(geojson)
    self.polygon = RGeo::GeoJSON.decode(geojson, geo_factory: RGeo::Cartesian.simple_factory(srid: 4326))
=begin
    coordinates = polygon
                    .geometry
                    .coordinates
                    .first
                    .map {|pair| pair.join(' ')}
                    .join(', ')
    query = "UPDATE cities SET polygon = ST_GeomFromText('POLYGON((#{coordinates}))',4326), updated_at = '#{Time.current.utc.iso8601}' WHERE id = '#{self.id}'"
    ActiveRecord::Base.connection.execute(query, :skip_logging)
=end
  end
end
