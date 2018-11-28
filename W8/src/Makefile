TARGET = run

all: $(TARGET)

$(TARGET): utils.cmo lexer.cmo parser.cmo lang.cmo typeof.cmo eval.cmo main.cmo
	ocamlc -o $@ $^

utils.cmo : utils.ml
	ocamlc -c utils.ml

lang.cmo : lang.ml utils.cmo
	ocamlc -c lang.ml

eval.cmo : eval.ml lang.cmo
	ocamlc -c eval.ml

typeof.cmo : typeof.ml lang.cmo
	ocamlc -c typeof.ml

parser.ml: parser.mly lang.cmo
	ocamlyacc parser.mly

parser.mli: parser.mly
	ocamlyacc parser.mly

parser.cmi: parser.mli
	ocamlc -c parser.mli

parser.cmo: parser.ml parser.cmi
	ocamlc -c parser.ml

main.cmo : lang.cmo eval.cmo typeof.cmo main.ml
	ocamlc -c main.ml

lexer.cmo: lexer.ml
	ocamlc -c lexer.ml

lexer.ml: lexer.mll parser.cmo
	ocamllex lexer.mll

clean:
	rm -f *.cmx *.cmi parser.mli parser.ml lexer.ml run *.o *.cmo