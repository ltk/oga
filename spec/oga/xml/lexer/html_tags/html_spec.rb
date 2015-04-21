require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'lexing <html> tags' do
    describe 'without an <html> opening tag' do
      it 'returns an empty Array when there are no elements' do
        lex_html('</html>').should == []
      end
    end

    describe 'without an <html> closing tag' do
      it 'adds the missing closing tag' do
        lex_html('<html>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end
  end
end
