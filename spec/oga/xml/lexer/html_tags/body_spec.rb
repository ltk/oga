require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'lexing <body> tags' do
    describe 'without <html> tags' do
      it 'wraps an <html> tag around a <body> tag' do
        lex_html('<body></body>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'body', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end

      it 'wraps an <html> tag around a <BODY> tag' do
        lex_html('<BODY></BODY>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'BODY', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end

    describe 'when a <meta> tag preceeds a <body> tag' do
      it 'ignores the <body> tag when the opening tag is missing' do
        lex_html('<meta></body>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'meta', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end

      it 'adds a missing <body> closing tag' do
        lex_html('<meta><body>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_NAME, 'meta', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_NAME, 'body', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end

    describe 'when a <body> opening tag is followed by a <meta> tag' do
      it 'nests the <meta> tag inside the <body> tag' do
        lex_html('<body><meta>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'body', 1],
          [:T_ELEM_NAME, 'meta', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end

    describe 'without a <body> closing tag' do
      it 'adds the missing closing tag' do
        lex_html('<body>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'body', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end
  end
end
