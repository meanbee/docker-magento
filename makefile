TEMPLATE_LIB=lib/**/*.m4

all: */*/Dockerfile

%: %.m4 $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.5/cli/Dockerfile: 5.5/cli/Dockerfile.m4 5.5/cli/php.ini $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.5/apache/Dockerfile: 5.5/apache/Dockerfile.m4 5.5/apache/php.ini 5.5/apache/magento.conf $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.6/cli/Dockerfile: 5.6/cli/Dockerfile.m4 5.6/cli/php.ini $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

5.6/apache/Dockerfile: 5.6/apache/Dockerfile.m4 5.6/apache/php.ini 5.6/apache/magento.conf $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

7.0/cli/Dockerfile: 7.0/cli/Dockerfile.m4 7.0/cli/php.ini $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@

7.0/apache/Dockerfile: 7.0/apache/Dockerfile.m4 7.0/apache/php.ini 7.0/apache/magento.conf $(TEMPLATE_LIB)
	m4 -I ./lib $@.m4 > $@
