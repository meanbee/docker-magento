TEMPLATE_LIB=lib/**/*.m4

all: */*/Dockerfile

%: %.m4 $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

%.sh: %.sh.m4 $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@
	chmod u+x $@

5.5/cli/Dockerfile: 5.5/cli/Dockerfile.m4 5.5/cli/php.ini 5.5/cli/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.5/fpm/Dockerfile: 5.5/fpm/Dockerfile.m4 5.5/fpm/php.ini 5.5/fpm/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.5/apache/Dockerfile: 5.5/apache/Dockerfile.m4 5.5/apache/php.ini 5.5/apache/magento.conf 5.5/apache/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.6/cli/Dockerfile: 5.6/cli/Dockerfile.m4 5.6/cli/php.ini 5.6/cli/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.6/fpm/Dockerfile: 5.6/fpm/Dockerfile.m4 5.6/fpm/php.ini 5.6/fpm/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.6/apache/Dockerfile: 5.6/apache/Dockerfile.m4 5.6/apache/php.ini 5.6/apache/magento.conf 5.6/apache/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

7.0/cli/Dockerfile: 7.0/cli/Dockerfile.m4 7.0/cli/php.ini 7.0/cli/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

7.0/apache/Dockerfile: 7.0/apache/Dockerfile.m4 7.0/apache/php.ini 7.0/apache/magento.conf 7.0/apache/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

7.0/fpm/Dockerfile: 7.0/fpm/Dockerfile.m4 7.0/fpm/php.ini 7.0/fpm/entrypoint.sh $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@
