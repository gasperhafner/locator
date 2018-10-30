class City < ApplicationRecord
  has_many :push_logs, dependent: :destroy
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

    find_by(
      query,
      srid: DEFAULT_SRID,
      longitude: longitude,
      latitude: latitude
    )
  end
end
