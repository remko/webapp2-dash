TARGET=WebApp2.docset
VERSION=2.5.1
PACKAGE=webapp2-$(VERSION)
DOCS=$(PACKAGE)/docs

all:
	sphinx-build $(DOCS) html
	-rm -rf $(TARGET)
	doc2dash --icon icon@2x.png -n $(basename $(TARGET)) --index-page index.html html
	-rm -rf dist
	mkdir dist
	tar --exclude='.DS_Store' -cvzf dist/$(basename $(TARGET)).tgz $(TARGET)
	cat docset.json | sed -e "s/{version}/$(VERSION)/" > dist/docset.json
	cp icon.png icon@2x.png dist

clean:
	-rm -rf $(TARGET) html dist

init: 
	$(PACKAGE)
	pip install -q -r requirements.txt

$(PACKAGE): $(PACKAGE).zip
	unzip $<

$(PACKAGE).zip:
	curl -O "https://webapp-improved.googlecode.com/files/$@"
