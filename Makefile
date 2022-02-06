all: bashdocs mkdocks

$(BASHDOCDIR)/%.md : $(BASHSOURCEDIR)/%.sh
	shdoc < $< > $@

bashdocs: $(BASHDOCTGTS)

clean:
	rm $(BASHDOCTGTS)
	rm databasedone.txt
	rm oldimportdone.txt

database: databasedone.txt

databasedone.txt :
	$(BASHSOURCEDIR)/createdb.sh
	$(BASHSOURCEDIR)/createtables.sh
	touch databasedone.txt

oldimport: oldimportdone.txt

oldimportdone.txt:
	$(BASHSOURCEDIR)/oldimport.sh
	touch oldimportdone.txt

mkdocs:
	mkdocs build	

install: docsinstall

schemadocs:
	$(BASHSOURCEDIR)/schemadoc.sh
	
docsinstall:
	$(BASHSOURCEDIR)/installwebdocs.sh

installreports:
	cp reports/* $(DOCWEBROOT/reports)	
