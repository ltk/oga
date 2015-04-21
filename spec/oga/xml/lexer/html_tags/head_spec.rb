require 'spec_helper'

describe Oga::XML::Lexer do
  describe 'lexing <head> tags' do
    describe 'without <html> tags' do
      it 'wraps an <html> tag around a <head> tag' do
        lex_html('<head></head>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end

      it 'wraps an <html> tag around a <HEAD> tag' do
        lex_html('<HEAD></HEAD>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'HEAD', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end

    describe 'without an <html> opening tag' do
      it 'adds the missing closing tag' do
        lex_html('<html><head></head>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end

    describe 'without an <html> closing tag' do
      it 'adds the missing opening tag' do
        lex_html('<head></head></html>').should == [
          [:T_ELEM_NAME, 'html', 1],
          [:T_ELEM_NAME, 'head', 1],
          [:T_ELEM_END, nil, 1],
          [:T_ELEM_END, nil, 1]
        ]
      end
    end
  end
end
