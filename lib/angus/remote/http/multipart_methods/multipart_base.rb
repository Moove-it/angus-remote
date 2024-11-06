require 'multipart/post'

module Http
  module MultipartMethods

    module MultipartBase
      DEFAULT_BOUNDARY = '-----------RubyMultipartPost'
      # prevent reinitialization of headers
      def initialize_http_header(initheader)
        super
        set_headers_for_body
      end

      def body=(value)
        @body_parts = value.map {|(k,v)| ::Multipart::Post::Parts::Part.new(boundary, k, v)}
        @body_parts << ::Multipart::Post::Parts::EpiloguePart.new(boundary)
        set_headers_for_body
      end

      def boundary
        DEFAULT_BOUNDARY
      end

      private

      def set_headers_for_body
        if @body_parts
          self.set_content_type('multipart/form-data', {'boundary' => boundary})
          self.content_length = @body_parts.inject(0) { |sum,i| sum + i.length }
          self.body_stream = ::Multipart::Post::CompositeReadIO.new(*@body_parts.map { |part| part.to_io })
        end
      end
    end

  end
end
