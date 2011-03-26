begin

  require 'metric_fu'
  require 'find'
  MetricFu::Configuration.run do |config|
    config.metrics = [:churn, :stats, :flog, :flay, :reek, :roodi, :rails_best_practices, :hotspots]
    config.graphs = [:stats, :flog, :flay, :reek, :roodi, :rails_best_practices]
    config.flay = {:dirs_to_flay => ['app', 'lib'], :minimum_score => 100}
    config.flog = {:dirs_to_flog => ['app', 'lib']}
    config.reek = {:dirs_to_reek => ['app', 'lib']}
    config.roodi = {:dirs_to_roodi => ['app', 'lib']}
    config.churn = {:start_date => "1 year ago", :minimum_churn_count => 10}
  end

  task :purge_old_metrics do
    MAXIMUM_FILE_AGE_IN_SECONDS = 60 * 60 * 24 * 28 # 4 weeks
    age_of_oldest_file_to_keep = (Time.now - MAXIMUM_FILE_AGE_IN_SECONDS).strftime('%Y%m%d').to_i
    Find.find('.') do |file_name|
      next unless File.file?(file_name) && (file_name =~ /\d{8}\.yml/) && (File.basename(file_name, '.yml').to_i < age_of_oldest_file_to_keep)
      `tar -rf archived-data.tar #{file_name}`
      File.delete(file_name)
    end
  end
rescue MissingSourceFile
end