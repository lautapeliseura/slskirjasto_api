all: bashdocs mkdocks

$(BASHDOCDIR)/%.md : $(BASHSOURCEDIR)/%.sh
	shdoc < $< > $@

bashdocs: $(BASHDOCTGTS)

clean:
	rm $(BASHDOCTGTS)
	rm databasedone.txt
	rm oldimportdone.txt

database: databasedone.txt views

databasedone.txt :
	$(BASHSOURCEDIR)/createdb.sh
	$(BASHSOURCEDIR)/createtables.sh
	touch databasedone.txt

views: 
	$(BASHSOURCEDIR)/createviews.sh

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
	[ -d $(DOCWEBROOT)/reports/pgsql ] || mkdir -p $(DOCWEBROOT)/reports/pgsql
	cp -r reports/* $(DOCWEBROOT)/reports	
