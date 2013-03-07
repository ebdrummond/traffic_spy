require "bundler/gem_tasks"
Bundler.require

namespace :db do
  desc "Run migrations"
  task :migrate => [:setup] do
    Sequel::Migrator.run(DB, "db/migrations")
  end

  desc "Reset database"
  task :reset => [:setup] do
    Sequel::Migrator.run(DB, "db/migrations", :target => 0)
    Sequel::Migrator.run(DB, "db/migrations")
  end

  task :setup do
    Sequel.extension :migration

    if ENV["TRAFFIC_SPY_ENV"] == "test"
      database_file = 'db/traffic_spy-test.sqlite3'
      DB = Sequel.sqlite database_file
    else
      DB = Sequel.postgres "traffic_spy"
    end

  end

  desc "Import dummy data to database"
  task :import => [:setup] do
    require 'date'
    DB[:accounts].insert(
        :identifier=>"account",
        :root_url=>"http://www.account.com"
    )
    10.times do |i|
      DB[:payloads].insert(
        :account_id=>1,
        :http_request=>nil,
        :query_strings=>nil,
        :url_id=>i+1,
        :referrer_id=>i+1,
        :event_id=>i+1,
        :resolution_id=>i+1,
        :ip_address_id=>i+1,
        :browser_id=>i+1,
        :operating_system_id=>i+1,
        :requested_at=>"2013-01-02 00:00:0#{i+1} -0700",
        :hour_of_day=>3,
        :responded_in=>17)
      DB[:urls].insert(:url=>"/some-sweet-page#{i+1}")
      DB[:browsers].insert(:browser=>"Chrome#{i+1}")
      DB[:operating_systems].insert(:operating_system =>"Mac OS X#{i+1}")
      DB[:resolutions].insert(:resolution => "1024 x 76#{i}")
      DB[:campaigns].insert(:campaign => "SuperDuperCampaign#{i}")
      DB[:events].insert(:event => "Viewed#{i}Things")
      DB[:campaign_events].insert(
        :account_id => 1,
        :campaign_id => i+1,
        :event_id => i+1)
    end
  end
end

# THIS SPACE RESERVED FOR EVALUATIONS
#
namespace :sanitation do
  desc "Check line lengths & whitespace with Cane"
  task :lines do
    puts ""
    puts "== using cane to check line length =="
    system("cane --no-abc --style-glob 'lib/**/*.rb' --no-doc")
    puts "== done checking line length =="
    puts ""
  end

  desc "Check method length with Reek"
  task :methods do
    puts ""
    puts "== using reek to check method length =="
    system("reek -n lib/**/*.rb 2>&1 | grep -v ' 0 warnings'")
    puts "== done checking method length =="
    puts ""
  end

  desc "Check both line length and method length"
  task :all => [:lines, :methods]
end
#
# THIS SPACE RESERVED FOR EVALUATIONS
