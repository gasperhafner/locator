namespace :city do
  desc "Import city polygons"
  task polygons: :environment do
    geojson_files = Dir.glob("#{Rails.root}/lib/tasks/polygons/cities.json")
    geojson_files.each do |file|
      polygons = RGeo::GeoJSON.decode(File.read(file), json_parser: :json)

      polygons.each do |polygon_points|
        name = polygon_points.properties["name"]

        next unless name.present?

        city = City.find_by(name: name)

        coordinates =
          polygon_points
            .geometry
            .coordinates
            .first
            .map {|pair| pair.join(' ')}
            .join(', ')

        if city
          sql = "UPDATE cities SET polygon = ST_GeomFromText('POLYGON((#{coordinates}))',4326), updated_at = '#{Time.current.utc.iso8601}' WHERE id = '#{city.id}'"
        else
          sql = "INSERT INTO cities (name, polygon, created_at, updated_at) VALUES('#{name}', ST_GeomFromText('POLYGON((#{coordinates}))',4326), '#{Time.current.utc.iso8601}', '#{Time.current.utc.iso8601}');"
        end
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end
end
