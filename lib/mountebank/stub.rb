class Mountebank::Stub
  attr_reader :responses, :predicates

  def initialize(data={})
    set_attributes(data)
  end

  def self.create(responses=[], predicates=[])
    data = {
      :responses => responses,
      :predicates => predicates
    }
    new(data)
  end

  def to_json(*args)
    data = {}
    data[:responses] = @responses unless @responses.empty?
    data[:predicates] = @predicates unless @predicates.empty?
    data.to_json(*args)
  end

  private

  def set_attributes(data={})
    @responses = []
    if data[:responses]
      data[:responses].each do |response|
        unless response.is_a? Mountebank::Stub::Response
          response = Mountebank::Stub::Response.new(response)
        end
        @responses << response
      end
    end

    @predicates = []
  end
end
