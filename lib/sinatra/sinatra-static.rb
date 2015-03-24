require 'sinatra/base'

module Sinatra
  module StaticPublish

    def static_publish(src_path,dist_path,reference_files)

      file_status = check_file(dist_path,reference_files,params)
      if file_status == :not_a_target then
        return make_response(src_path,file_status,params['dist_path'])
      elsif file_status == :suspend then
        buf = request.url.split('?')
        if buf.size > 1 then
          force_url = request.url + '&'
        else
          force_url = request.url + '?'
        end
        force_url += "force=true&dist_path=#{dist_path}"
        return make_response(src_path,file_status,force_url)
      end

      status, header, body = call env.merge("PATH_INFO" => src_path).merge("REQUEST_METHOD" => "GET")
      return make_response(src_path,:error,status) if status != 200

      dist_fullpath = settings.public_folder + dist_path

      body = body[0]
      if file_status != :create then
        body_old = File.open(dist_fullpath,'r').read
        return make_response(src_path,:no_change,dist_path) if body==body_old
      end

      File.open(dist_fullpath,'w').write(body)
      return make_response(src_path,file_status,dist_path)
    end

    #private

    def make_response(src_path,status,option)
      case status
        when :suspend
          return [status.to_s,src_path,(haml "%a(href=#{option} target=blank) force-update the static file")]
        when :error
          return [status.to_s,src_path,"Error Code: #{option}"]
      end
      return [status.to_s,src_path,option]
    end

    def is_newer_file?(path1,path2)
      File::Stat.new(path1) <=> File::Stat.new(path2)
    end

    def check_file(dist_path,reference_files,params)
      if params['dist_path'] then
        return :not_a_target if dist_path != params['dist_path']
      end

      dist_fullpath = settings.public_folder + dist_path
      unless File.exist?(dist_fullpath) then
        dirname = File.dirname(dist_fullpath)
        FileUtils.mkdir_p(dirname,{:mode=>0755}) unless File.exist?(dirname)
        return :create
      end

      if params['force'] then
        return :overwrite
      end

      reference_files.each{|f|
        return :overwrite if is_newer_file?(f,dist_fullpath)
      }

      return :suspend
    end

  end
  register StaticPublish
end
