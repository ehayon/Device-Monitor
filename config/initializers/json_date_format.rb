class ActiveSupport::TimeWithZone
    def as_json(options = {})
        strftime('%Y-%m-%d %H:%M:%S')
    end
    def to_s(options = {})
        strftime('%Y-%m-%d %H:%M:%S')
    end
end