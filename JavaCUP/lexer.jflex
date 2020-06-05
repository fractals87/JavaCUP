package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%

%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
Whitespace   = [ \t\f] | {Newline}
NumberInt    = [0-9]+
NumberFloat  = [0-9]+.[0-9]{1,5}
Id			 = [a-z]+

%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {

  {Whitespace} {                              }
  ";"           { return symbolFactory.newSymbol("SEMI", SEMI); }
  "="           { return symbolFactory.newSymbol("ASSIGN", ASSIGN); }
  "+"           { return symbolFactory.newSymbol("PLUS", PLUS); }
  "-"           { return symbolFactory.newSymbol("MINUS", MINUS); }
  "*"           { return symbolFactory.newSymbol("TIMES", TIMES); }
  "/"           { return symbolFactory.newSymbol("DIV", DIV); }
  "int"         { return symbolFactory.newSymbol("TYINT", TYINT); }
  "float"       { return symbolFactory.newSymbol("TYFLOAT", TYFLOAT); }
  "print"	    { return symbolFactory.newSymbol("PRINT", PRINT); }
  {Id}          { return symbolFactory.newSymbol("ID", ID, yytext()); }
  {NumberInt}   { return symbolFactory.newSymbol("INT", INT, yytext()); }
  {NumberFloat} { return symbolFactory.newSymbol("FLOAT", FLOAT, yytext()); }
}



// error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }
