install:
	install -p -m 644 smt.scm /usr/share/guile/site

uninstall:
	rm -f /usr/share/guile/site/smt.scm
